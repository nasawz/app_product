(function (factory) {
  /* global define */
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else {
    // Browser globals: jQuery
    factory(window.jQuery);
  }
}(function ($) {
  // template
  var tmpl = $.summernote.renderer.getTemplate();

  /**
   * @class plugin.bal_media
   *
   * Hello Plugin
   */
  $.summernote.addPlugin({
    /** @property {String} name name of plugin */
    name: 'bal_media',
    /**
     * @property {Object} buttons
     * @property {Function} buttons.hello   function to make button
     * @property {Function} buttons.helloDropdown   function to make button
     * @property {Function} buttons.helloImage   function to make button
     */
    buttons: { // buttons
      bal_media: function (lang, options) {

        return tmpl.iconButton(options.iconPrefix + 'archive', {
          event : 'bal_media',
          title: '媒体库',
          hide: true
        });
      }

    },

    /**
     * @property {Object} events
     * @property {Function} events.hello  run function when button that has a 'hello' event name  fires click
     * @property {Function} events.helloDropdown run function when button that has a 'helloDropdown' event name  fires click
     * @property {Function} events.helloImage run function when button that has a 'helloImage' event name  fires click
     */
    events: { // events
      bal_media: function (event, editor, layoutInfo) {
        // Get current editable node
        var $editable = layoutInfo.editable();

        // Call insertText with 'hello'
        editor.insertText($editable, 'hello ');
      }
    }
  });
}));
