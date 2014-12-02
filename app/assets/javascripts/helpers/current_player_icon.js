Ember.Handlebars.registerBoundHelper('currentPlayerIcon', function (a, b, options) {
  if (a == b) {
    return new Handlebars.SafeString('<div class="current-player-icon"><span class="glyphicon glyphicon-user"></span></div>');
  } else {
    return '';
  }
});
