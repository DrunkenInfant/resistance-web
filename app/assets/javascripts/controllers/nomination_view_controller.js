Resistance.NominationViewController = Ember.Controller.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  actions: {
    accept: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('model'),
        pass: true
      }).save();
      this.get('controllers.game.model').reload();
    },
    reject: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('model'),
        pass: false
      }).save();
      this.get('controllers.game.model').reload();
    }
  }
});
