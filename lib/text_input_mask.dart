import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({
    @required this.mask,
  }) {
    assert(mask != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;

        final StringBuffer newText = new StringBuffer();
        int selectionEnd = newValue.selection.end;

        int maskPos = oldValue.text.length + 1;
        String charMask;
        if (maskPos > 0) {
          charMask = mask.substring(maskPos - 1, maskPos);
        } else if (maskPos == 0) {
          charMask = mask.substring(maskPos, maskPos);
        }

        if (charMask != '#') {
          if (newValue.text.length <= 1) {
            newText.write(charMask);
            newText.write(newValue.text);
            
          }else{
            newText.write(oldValue.text.toString());
            newText.write(charMask);
            newText.write(newValue.text.substring(newValue.text.length-1, newValue.text.length));
            
          }

          selectionEnd++;
        } else {
          newText.write(newValue.text);
        }

        return TextEditingValue(
          text: newText.toString(),
          selection: TextSelection.collapsed(
            offset: selectionEnd,
          ),
        );
      }
    }
    return newValue;
  }
}
