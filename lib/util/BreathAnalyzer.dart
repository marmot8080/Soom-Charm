import 'dart:async';
import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:record/record.dart';

class BreathAnalyzer {
  final _recorder = AudioRecorder();
  StreamSubscription? _recorderSubscription;
  final int sampleRate = 44100;
  final int chunkSize = 1024;

  // 바람 소리 감지를 위한 콜백 함수
  Function(double)? onEnergyDetected;

  BreathAnalyzer({this.onEnergyDetected});

  // 마이크 입력 시작
  Future<void> startListening() async {
    if (await _recorder.hasPermission()) { // 마이크 권한 확인
      // 스트림 열기
      final stream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
        ),
      );

      // 오디오 데이터 읽을 때마다 오디오 데이터 처리
      _recorderSubscription = stream.listen((audioData) {
        if (audioData != null) {
          _processAudioData(audioData);
        }
      });
    }
  }

  // 오디오 데이터를 FFT로 처리
  void _processAudioData(Uint8List audioData) {
    // PCM 데이터를 Float로 변환 (16-bit PCM -> Float32)
    var buffer = ByteData.sublistView(audioData);
    var floatData = Float32List(audioData.length ~/ 2); // 16비트 PCM 데이터를 Float로 변환

    for (int i = 0; i < floatData.length; i++) {
      floatData[i] = buffer.getInt16(i * 2, Endian.little) / 32768.0;
    }

    // 저주파 에너지 계산
    double lowFreqEnergy = _calculateLowFreqEnergy(floatData);

    // 콜백 함수로 저주파 에너지를 전달
    if (onEnergyDetected != null) {
      onEnergyDetected!(lowFreqEnergy);
    }
  }

  // 마이크 입력 중지
  Future<void> stopListening() async {
    if (await _recorder.isRecording()) {
      await _recorder.stop();
      await _recorder.cancel();
      _recorder.dispose();
      _recorderSubscription?.cancel();
    }
  }

  // 저주파 에너지를 계산하는 함수
  double _calculateLowFreqEnergy(Float32List floatData) {
    final FFT fft = FFT(floatData.length); // 전체 데이터를 한 번에 처리할 FFT 생성
    var lowFreqEnergy = 0.0; // 총 저주파 에너지 합

    // FFT 실행
    var spectrum = fft.realFft(floatData); // FFT 결과는 복소수 스펙트럼

    var magnitudes = spectrum.magnitudes(); // 진폭 계산

    // 0Hz ~ 200Hz 범위의 에너지를 계산
    for (int i = 0; i < magnitudes.length; i++) {
      double frequency = (i * sampleRate) / floatData.length; // 주파수 계산

      if (frequency >= 0 && frequency < 200) { // 0Hz ~ 200Hz 범위의 에너지를 합산
        lowFreqEnergy += magnitudes[i];
      }
    }

    return lowFreqEnergy;
  }
}
