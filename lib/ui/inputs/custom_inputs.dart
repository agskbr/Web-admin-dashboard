import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration authInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo.withOpacity(0.3),
        ),
      ),
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
    );
  }
}
