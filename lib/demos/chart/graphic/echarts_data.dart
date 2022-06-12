const areaStackGradientData = [
  {'day': 'Mon', 'value': 140, 'group': 1},
  {'day': 'Tue', 'value': 232, 'group': 1},
  {'day': 'Wed', 'value': 101, 'group': 1},
  {'day': 'Thu', 'value': 264, 'group': 1},
  {'day': 'Fri', 'value': 90, 'group': 1},
  {'day': 'Sat', 'value': 340, 'group': 1},
  {'day': 'Sun', 'value': 250, 'group': 1},
  {'day': 'Mon', 'value': 120, 'group': 2},
  {'day': 'Tue', 'value': 282, 'group': 2},
  {'day': 'Wed', 'value': 111, 'group': 2},
  {'day': 'Thu', 'value': 234, 'group': 2},
  {'day': 'Fri', 'value': 220, 'group': 2},
  {'day': 'Sat', 'value': 340, 'group': 2},
  {'day': 'Sun', 'value': 310, 'group': 2},
  {'day': 'Mon', 'value': 320, 'group': 3},
  {'day': 'Tue', 'value': 132, 'group': 3},
  {'day': 'Wed', 'value': 201, 'group': 3},
  {'day': 'Thu', 'value': 334, 'group': 3},
  {'day': 'Fri', 'value': 190, 'group': 3},
  {'day': 'Sat', 'value': 130, 'group': 3},
  {'day': 'Sun', 'value': 220, 'group': 3},
  {'day': 'Mon', 'value': 220, 'group': 4},
  {'day': 'Tue', 'value': 402, 'group': 4},
  {'day': 'Wed', 'value': 231, 'group': 4},
  {'day': 'Thu', 'value': 134, 'group': 4},
  {'day': 'Fri', 'value': 190, 'group': 4},
  {'day': 'Sat', 'value': 230, 'group': 4},
  {'day': 'Sun', 'value': 120, 'group': 4},
  {'day': 'Mon', 'value': 220, 'group': 5},
  {'day': 'Tue', 'value': 302, 'group': 5},
  {'day': 'Wed', 'value': 181, 'group': 5},
  {'day': 'Thu', 'value': 234, 'group': 5},
  {'day': 'Fri', 'value': 210, 'group': 5},
  {'day': 'Sat', 'value': 290, 'group': 5},
  {'day': 'Sun', 'value': 150, 'group': 5},
];

const lineMarkerData = [
  {'day': 'Mon', 'value': 10, 'group': 'Highest'},
  {'day': 'Tue', 'value': 11, 'group': 'Highest'},
  {'day': 'Wed', 'value': 13, 'group': 'Highest'},
  {'day': 'Thu', 'value': 11, 'group': 'Highest'},
  {'day': 'Fri', 'value': 12, 'group': 'Highest'},
  {'day': 'Sat', 'value': 12, 'group': 'Highest'},
  {'day': 'Sun', 'value': 9, 'group': 'Highest'},
  {'day': 'Mon', 'value': 1, 'group': 'Lowest'},
  {'day': 'Tue', 'value': -2, 'group': 'Lowest'},
  {'day': 'Wed', 'value': 2, 'group': 'Lowest'},
  {'day': 'Thu', 'value': 5, 'group': 'Lowest'},
  {'day': 'Fri', 'value': 3, 'group': 'Lowest'},
  {'day': 'Sat', 'value': 2, 'group': 'Lowest'},
  {'day': 'Sun', 'value': 0, 'group': 'Lowest'},
];

const lineSectionsData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [
    300,
    280,
    250,
    260,
    270,
    300,
    550,
    500,
    400,
    390,
    380,
    390,
    400,
    500,
    600,
    750,
    800,
    700,
    600,
    400
  ],
];

const lineSectionsData2 = [
  ['00:00', 300],
  ['01:15', 280],
  ['02:30', 250],
  ['03:45', 260],
  ['05:00', 270],
  ['06:15', 300],
  ['07:30', 550],
  ['08:45', 500],
  ['10:00', 400],
  ['11:15', 390],
  ['12:30', 380],
  ['13:45', 390],
  ['15:00', 400],
  ['16:15', 500],
  ['17:30', 600],
  ['18:45', 750],
  ['20:00', 800],
  ['21:15', 700],
  ['22:30', 600],
  ['23:45', 400]
];

const lineMarkerData2 = [
  {'time': '00:00', 'value': 300, 'group': 'Highest'},
  {'time': '01:15', 'value': 280, 'group': 'Highest'},
  {'time': '02:30', 'value': 250, 'group': 'Highest'},
  {'time': '03:45', 'value': 260, 'group': 'Highest'},
  {'time': '05:00', 'value': 270, 'group': 'Highest'},
  {'time': '06:15', 'value': 300, 'group': 'Highest'},
  {'time': '07:30', 'value': 550, 'group': 'Highest'},
  {'time': '08:45', 'value': 500, 'group': 'Lowest'},
  {'time': '10:00', 'value': 400, 'group': 'Lowest'},
  {'time': '11:15', 'value': 390, 'group': 'Lowest'},
  {'time': '12:30', 'value': 400, 'group': 'Lowest'},
  {'time': '13:45', 'value': 500, 'group': 'Lowest'},
  {'time': '15:00', 'value': 600, 'group': 'Lowest'},
  {'time': '16:15', 'value': 750, 'group': 'Lowest'},
  {'time': '17:30', 'value': 800, 'group': 'Lowest'},
  {'time': '18:45', 'value': 600, 'group': 'Lowest'},
  {'time': '20:00', 'value': 750, 'group': 'Lowest'},
  {'time': '21:15', 'value': 853, 'group': 'Lowest'},
  {'time': '22:30', 'value': 350, 'group': 'Lowest'},
  {'time': '23:45', 'value': 420, 'group': 'Lowest'},
];
