Resistance.NominationCreateController = Ember.Controller.extend({
  actions: {
    select: function (player) {
      if (this.model.get('players').contains(player)) {
        this.model.get('players').removeObject(player);
      } else {
        this.model.get('players').addRecord(player);
      }
    },
    nominate: function () {
      this.model.save();
      this.model.notifyPropertyChange();
    }
  }
});
