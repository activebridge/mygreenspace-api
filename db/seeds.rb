User.create([
  {
    first_name:     'Filippos',
    last_name:      'Roni'
  },
  {
    first_name:     'Nadim',
    last_name:      'Enes'
  },
])

Space.create([
  {
    width:          100,
    length:         200,

    user_id:        1
  },
  {
    width:          50,
    length:         100,

    user_id:        1
  },
  {
    width:          1000,
    length:         1000,

    user_id:        2
  },
])
