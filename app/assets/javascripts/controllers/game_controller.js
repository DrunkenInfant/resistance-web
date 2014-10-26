Resistance.GameController = Ember.Controller.extend({
  needs: ['application'],
  currentPlayer: function () {
    return this.get('model.players').findBy('user',
      this.get('controllers.application.currentUser'));
  }.property('model.players.@each', 'controllers.application.currentUser'),
});
