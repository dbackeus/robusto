Template.meetingsIndex.helpers
  meetings: ->
    Meetings.find()

Template.meetingsShow.helpers
  participations: ->
    Participations.find({meeting_id: @_id})

Template.participation.helpers
  name: ->
    Meteor.users.findOne(@user_id).profile.name

  points: ->
    if typeof @points != "undefined"
      @points
    else
      "waiting for points"

  fibonacci: ->
    [0,1,2,3,5,8]

  currentUser: ->
    Meteor.userId() == @user_id

Template.participation.events
  "click a[data-points]": (e) ->
    e.preventDefault()

    $link = $(e.target)
    points = $link.data("points")
    participationId = $link.closest("[data-participation-id]").data("participationId")

    Participations.update({_id: participationId}, $set: {points: points})
