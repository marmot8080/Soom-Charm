import 'dart:async';
import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:record/record.dart';
import 'package:flutter/foundation.dart';

class BreathAnalyzer {
  final _recorder = AudioRecorder();
  StreamSubscription? _recorderSubscription;
  final int sampleRate = 44100;
  final int chunkSize = 1024;
  final STFT stft = STFT(1024, Window.hanning(1024));

  // 바람 소리 감지를 위한 콜백 함수
  Function(double)? onEnergyDetected;

  BreathAnalyzer({this.onEnergyDetected});

  // 마이크 입력 시작
  Future<void> startListening() async {
    if (await _recorder.hasPermission()) {
      // Start recording to stream
      final stream = await _recorder.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits),
      );

      _recorderSubscription = stream.listen((audioData) {
        if (audioData != null) {
          _processAudioData(audioData);
        }
      });
    }
  }

  // 오디오 데이터를 FFT로 처리
  void _processAudioData(Uint8List audioData) async {
    // PCM 데이터를 Float로 변환 (16-bit PCM -> Float32)
    var buffer = ByteData.sublistView(audioData);
    var floatData = Float32List(audioData.length ~/ 2);  // 16비트 PCM 데이터를 Float로 변환

    for (int i = 0; i < floatData.length; i++) {
      floatData[i] = buffer.getInt16(i * 2, Endian.little) / 32768.0;
    }

    // FFT 계산을 Isolate에서 수행
    var lowFreqEnergy = await compute(_calculateLowFreqEnergy, floatData);

    if (onEnergyDetected != null) {
      onEnergyDetected!(lowFreqEnergy);
    }
  }

  // 마이크 입력 중지
  Future<void> stopListening() async {
    if (await _recorder.isRecording()) {
      await _recorder.stop();
      _recorderSubscription?.cancel();
    }
  }
}

// Isolate에서 실행할 함수 (FFT 계산)
double _calculateLowFreqEnergy(Float32List floatData) {
  final STFT stft = STFT(1024, Window.hanning(1024));
  var lowFreqEnergy = 0.0;

  // STFT를 사용하여 주파수 분석
  stft.run(floatData, (Float64x2List freq) {
    var magnitudes = freq.discardConjugates().magnitudes();

    for (int i = 0; i < magnitudes.length; i++) {
      double frequency = stft.frequency(i, 44100.0);  // 44100 샘플링 주파수 기준
      if (frequency >= 0 && frequency < 200) {  // 0Hz ~ 200Hz 범위의 에너지 계산
        lowFreqEnergy += magnitudes[i];
      }
    }
  });

  return lowFreqEnergy;
}
