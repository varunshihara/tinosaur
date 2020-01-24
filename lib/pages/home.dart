import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
                child: Image.asset(
                  'assets/images/logo-full.png',
                  fit: BoxFit.contain,
                  height: 70,
                ),
              ),
              Image.network(
                'https://i0.wp.com/www.tinosaur.in/wp-content/uploads/banner-10small-e1548361489913.jpg?w=1200',
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                      child: Image.network(
                        'https://www.tinosaur.in/wp-content/uploads/banner-56-2-e1548583587857.jpg',
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
                      child: Image.network(
                        'https://www.tinosaur.in/wp-content/uploads/banner-55small-e1548360216147.jpg',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
