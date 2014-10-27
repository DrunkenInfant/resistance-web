Resistance.NominationCreateController = Ember.Controller.extend({
  init: function () {
    this._super();
    this.set('nomination', this.get('model').newNomination());
  },
  actions: {
    select: function (player) {
      if (this.get('nomination.players').contains(player)) {
        this.get('nomination.players').removeObject(player);
      } else {
        this.get('nomination.players').addRecord(player);
      }
    },
    nominate: function () {
      this.get('nomination').save();
    }
  }
});
