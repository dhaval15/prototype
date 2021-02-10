library fountain;

export 'src/sprinkle/sprinkle.dart';
export 'src/sprinkle/sprinkle_builder.dart';
export 'src/vein/handler.dart';
export 'src/vein/vein_stub.dart'
    if (dart.library.io) 'src/vein/vein.dart'
    if (dart.library.html) 'src/vein/vein_web.dart';
