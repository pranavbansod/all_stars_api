const m = require('mithril');

let team = require('../models/team');

module.exports = {
    oninit:function() {
      // console.log("Team On init");
        team.fetchPlayers();
    },
    view: function () {
        return [
            m('h1','All Star 2018'),
            m('button',{href:'/addPlayer' ,oncreate: m.route.link},"+"),
            m('.player-list',team.players.map(function (player) {
                return m('h1',m('button',player.name));
            }))
        ];

    }
};