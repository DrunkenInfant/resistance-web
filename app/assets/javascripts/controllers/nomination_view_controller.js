Resistance.NominationViewController = Ember.Controller.extend({
  actions: {
    accept: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('model'),
        pass: true
      }).save();
    },
    reject: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('model'),
        pass: false
      }).save();
    }
  }
});
