Resistance.SocketController = Ember.Controller.extend({
  setupSocket: function () {
    if (this.get('socket')) {
      this.get('socket').disconnect();
    }
    var socket = new WebSocketRails('localhost:3000/websocket');
    socket.on_open = function (event) {
    };
    socket.bind("game.update", function (data) {
      this.store.serializerFor('game').pushPayload(this.store, data);
    }.bind(this));
    this.set('socket', socket);
  }
});
