
Resistance.ApplicationStore = DS.Store.extend({

});

Resistance.ApplicationAdapter = DS.ActiveModelAdapter.extend({
});

$(function() {
  var token = $('meta[name="csrf-token"]').attr('content');
  Resistance.csrfToken = token;
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
    return xhr.setRequestHeader('X-CSRF-Token', Resistance.csrfToken);
  });
});
