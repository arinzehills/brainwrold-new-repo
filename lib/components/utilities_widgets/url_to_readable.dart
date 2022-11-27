class UrlToReadable {
  static urlToReadableURL(String url, format) {
    var pos = url.lastIndexOf('.');
    var pre = url.indexOf('http');
    String result = (pos != -1) ? url.substring(0, pos) : url;
    return result + format;
  }

  static videoUrlToReadableURL(String url, format) {
    var pos = url.lastIndexOf('.');
    var pre = url.indexOf(':');
    var preUrl = url.substring(pre);
    var processUrl = UrlToReadable.urlToReadableURL(preUrl, '.mp4');
    return 'https' + processUrl;
  }
}
