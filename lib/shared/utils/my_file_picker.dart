import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

@JS("document")
external _Document get _document;

extension type _Document._(JSObject _) implements JSObject {
  external _Input createElement(String tag);
}

extension type _Input._(JSObject _) implements JSObject {
  external set type(String value);
  external set accept(String value);
  external _FileList? get files;
  external void click();
  external void addEventListener(String type, JSFunction listener);
}

extension type _FileList._(JSObject _) implements JSObject {
  external _File? item(int index);
}

extension type _File._(JSObject _) implements JSObject {
  external String get name;
  external String get type;
  external int get size;
  external JSPromise<JSArrayBuffer> arrayBuffer();
}

class MyPickedFile {
  const MyPickedFile({
    required this.name,
    required this.type,
    required this.size,
    required this.bytes,
  });

  final String name, type;
  final int size;
  final Uint8List bytes;
}

Future<MyPickedFile?> pickMyFile({required String accept}) {
  final completer = Completer<MyPickedFile?>();
  final input = _document.createElement("input")
    ..type = "file"
    ..accept = accept;

  input.addEventListener(
    "change",
    ((JSAny _) {
      _readFile(input.files?.item(0), completer);
    }).toJS,
  );
  input.addEventListener(
    "cancel",
    ((JSAny _) {
      if (!completer.isCompleted) completer.complete(null);
    }).toJS,
  );
  input.click();

  return completer.future;
}

Future<void> _readFile(_File? file, Completer<MyPickedFile?> completer) async {
  if (file == null) return completer.complete(null);

  final buffer = await file.arrayBuffer().toDart;
  completer.complete(
    MyPickedFile(
      name: file.name,
      type: file.type,
      size: file.size,
      bytes: buffer.toDart.asUint8List(),
    ),
  );
}
