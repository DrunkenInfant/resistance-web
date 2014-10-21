Resistance.Session = DS.Model.extend({
  user: DS.belongsTo('user', { async: true }),
  csrfToken: DS.attr(),
  email: DS.attr(),
  password: DS.attr()
});
