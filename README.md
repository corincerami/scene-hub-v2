## User Stories

### As a musician
  I want to be able to post about local shows
  So people can come watch our band play

#### Acceptance Criteria
- [x] Users can post shows
- [x] Shows include at least one band
- [x] Shows include a venue
- [x] Shows include details and a datetime
- [x] Shows can be viewed on a show page

### As a fan
  I want to be able to see all of the shows happening in my area
  So I can find some cool music to see

#### Acceptance Criteria
- [x] Shows must be geocoded in the database
- [x] Users can search by zip code
- [x] Users can select a distance radius
- [x] Users can see all shows within the chosen radius

### As a musician
  I want to be able to edit shows I've posted
  So I can keep my fans up to date

#### Acceptance Criteria
- [x] Clicking on an Edit Show button should bring me to an edit form
- [x] Submitting a valid form should bring me back to the show page
- [x] Submitting an invalid form should re-render the form with an error

### As a musician
  I want to be able to delete shows I've posted
  So I can remove shows that are cancelled

#### Acceptance Criteria
- [x] Click on a Delete Show button should show a confirmation dialog
- [x] Confirming should delete the show and redirect to the index

### As a musician
  I want to create bands I belong to on my profile page
  So that I can post about shows for my band

#### Acceptance Criteria
- [x] Visiting my profile should give me the option to create a new band
- [x] Creating a new show should have a dropdown menu of bands I belong to
- [x] Trying to create a show when I don't have any bands should direct me to my profile

### As a User
  I want to comment on shows
  So I can communicate with other people who are going

#### Acceptance Criteria
- [ ] Clicking on the comment button should take me to a comments form
- [ ] Comments should have a body and an optional title
- [ ] Upon submitting my comment, I should see it on the show page

### As a User
  I want to search for shows based on genre
  So I can find bands that fit my style

### As a musician
  I want to post status alerts to my profile
  So that I can share news with my fans

### As a fan
  I want to be able to view a band's profile
  So that I can follow what they're doing

Bugs list
- Currently if a user tries to create a band on another user's profile it allows them to, although the band still belongs to the signed in user. Instead it should not show that link on other users' profiles.
