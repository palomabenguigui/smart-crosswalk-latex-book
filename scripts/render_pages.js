// render_pages.js – render every page of a PDF to PNG with macOS PDFKit (no extra installs).
// Usage: osascript -l JavaScript scripts/render_pages.js <abs/path/file.pdf> <abs/out/prefix> [scale]
// Output: <prefix>-01.png, <prefix>-02.png, ...
ObjC.import('PDFKit');
ObjC.import('AppKit');
function run(argv) {
  var doc = $.PDFDocument.alloc.initWithURL($.NSURL.fileURLWithPath(argv[0]));
  if (doc.isNil()) { throw new Error('cannot open ' + argv[0]); }
  var scale = argv.length > 2 ? parseFloat(argv[2]) : 2.0;
  var n = doc.pageCount;
  for (var i = 0; i < n; i++) {
    var page = doc.pageAtIndex(i);
    var b = page.boundsForBox($.kPDFDisplayBoxMediaBox);
    var img = page.thumbnailOfSizeForBox($.NSMakeSize(b.size.width * scale, b.size.height * scale),
                                         $.kPDFDisplayBoxMediaBox);
    var rep = $.NSBitmapImageRep.imageRepWithData(img.TIFFRepresentation);
    var num = ('0' + (i + 1)).slice(-2);
    rep.representationUsingTypeProperties($.NSBitmapImageFileTypePNG, $({}))
       .writeToFileAtomically(argv[1] + '-' + num + '.png', true);
  }
  return 'rendered ' + n + ' pages';
}
