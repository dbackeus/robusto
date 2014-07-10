Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  waitOn: -> [
    Meteor.subscribe("meetings"),
    Meteor.subscribe("participations"),
    Meteor.subscribe("users"),
  ]

Router.map ->
  @route "meetingsIndex", path: "/"
  @route "meetingsShow",
    path: "/meetings/:_id",
    data: -> Meetings.findOne(@params._id)

Router.onBeforeAction("loading")
