Resistance.NominationCreateController = Ember.Controller.extend({
	actions: {
		select: function (player) {
			player.set('selected', !player.get('selected'));
		},
        nominate: function () {
			var nom = this.store.createRecord('nomination', {
				mission: this.model.get('currentMission')
			});
			nom.get('players').addObjects(this.model.get('players')
				.filter(function (p) {
					return p.selected;
				})
			);
			nom.save();
        }

	}
});
