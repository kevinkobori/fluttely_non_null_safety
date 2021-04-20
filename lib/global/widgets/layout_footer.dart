import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LayoutFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Spacer(),
          ResponsiveVisibility(
            visible: false,
            visibleWhen: [
              Condition.smallerThan(name: DESKTOP),
            ],
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '  Site feito em Flutter',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '  Remottely  /',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '  github  /',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '  YouTube  ',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleWhen: [
              Condition.equals(name: DESKTOP),
            ],
            child: Row(
              children: [
                Image.asset(
                  'assets/logos/marca_dagua.png',
                  height: 25,
                  width: 25,
                  fit: BoxFit.cover,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '    Remottely  /',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '  github  /',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '  YouTube  ',
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Site feito em Flutter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
