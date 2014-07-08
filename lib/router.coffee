Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"

Router.map ->
  @route "meetingsIndex", path: "/"
  @route "meetingsShow",
    path: "/meetings/:_id",
    data: -> Meetings.findOne(@params._id)
