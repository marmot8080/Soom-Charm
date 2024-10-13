import 'package:flutter/material.dart';

class rankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 77.20,
          height: 162.30,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 4,
                top: 138,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 11),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFBD3A5),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFFF6EF89),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFFEEA5FB),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFFA5B5FB),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFF82EDDF),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFBA5A5),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 3.74,
                top: 39.20,
                child: Container(
                  width: 69,
                  height: 89,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCBE3FA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 95,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '4.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 6,
                      fontFamily: 'Irish Grover',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 61,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '2.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFC0C0C0),
                      fontSize: 6,
                      fontFamily: 'Irish Grover',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 13,
                top: 77,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '1.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 6,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 3,
                child: SizedBox(
                  width: 48,
                  height: 8,
                  child: Text(
                    'Ranking',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 29,
                child: SizedBox(
                  width: 45,
                  height: 10,
                  child: Text(
                    '탁구공 오래띄우기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 44,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '1.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFCC25),
                      fontSize: 6,
                      fontFamily: 'Irish Grover',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 78,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '3.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD78F3D),
                      fontSize: 6,
                      fontFamily: 'Irish Grover',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 112,
                child: SizedBox(
                  width: 6,
                  height: 8,
                  child: Text(
                    '5.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 6,
                      fontFamily: 'Irish Grover',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
