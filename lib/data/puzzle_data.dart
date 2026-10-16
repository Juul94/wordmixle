import '../models/game_variant.dart';
import 'puzzle_data_da.dart';

/// Puzzle data for all 6 variants, 100 levels each.
/// Each variant returns the answer for a given level.

const _classicWords = [
  // Easy 1-20
  'apple', 'house', 'water', 'earth', 'light', 'music', 'dance', 'bread',
  'dream', 'cloud', 'stone', 'flame', 'bloom', 'smile', 'plant', 'night',
  'queen', 'river', 'tiger', 'watch',
  // Medium 21-50
  'brain', 'chess', 'crane', 'dwarf', 'eagle', 'frost', 'ghost', 'honey',
  'ivory', 'joker', 'kneel', 'lunar', 'marsh', 'novel', 'orbit', 'prism',
  'quilt', 'radar', 'solar', 'thorn', 'ultra', 'vault', 'whale', 'xenon',
  'yacht', 'zebra', 'blaze', 'cliff', 'delta', 'ember',
  // Hard 51-100
  'forge', 'glyph', 'haven', 'intro', 'jewel', 'karma', 'latch', 'moose',
  'nexus', 'omega', 'plumb', 'quest', 'rusty', 'siege', 'truce', 'unity',
  'vigor', 'wrist', 'oxide', 'yield', 'zilch', 'adept', 'brisk', 'clamp',
  'dodge', 'exile', 'flint', 'grind', 'hoist', 'input', 'jumbo', 'knack',
  'lymph', 'moist', 'nudge', 'optic', 'perch', 'quota', 'ridge', 'skulk',
  'tempt', 'usurp', 'vivid', 'whisk', 'expat', 'yeast', 'zonal', 'abode',
  'brine', 'crisp',
];

const _numberleAnswers = [
  // Easy 1-20 (5-digit numbers as strings)
  '12345', '54321', '11223', '99887', '10203', '30201', '42042', '13579',
  '24680', '11111', '22222', '33333', '44444', '55555', '12321', '45654',
  '67876', '10101', '20202', '30303',
  // Medium 21-50
  '98765', '86420', '75319', '64208', '53197', '97531', '19753', '31975',
  '80246', '46802', '15926', '37148', '59370', '71592', '93714', '26048',
  '48260', '60482', '82604', '04826', '17395', '39517', '51739', '73951',
  '95173', '28406', '40628', '62840', '84062', '06284',
  // Hard 51-100
  '74185', '29630', '85274', '36925', '14703', '69258', '25814', '70369',
  '81472', '92583', '03694', '47036', '58147', '69258', '70369', '81470',
  '92581', '03692', '14703', '25814', '36925', '47036', '58147', '69258',
  '70360', '81471', '92582', '03693', '14704', '25815', '36926', '47037',
  '58148', '69259', '70361', '81472', '92583', '03694', '14705', '25816',
  '36927', '47038', '58149', '69250', '70362', '81473', '92584', '03695',
  '14706', '25817',
];

/// EmojiLink: emojis as clues, answer is a 5-letter English word
const _emojiClues = [
  // Easy 1-20
  '🏄🌅', '😁🪥', '💉🔴', '🎨🌈', '🌧️🏊',
  '🎩✨', '🔥💨', '🚗💥', '😴🛏️', '🍯🎂',
  '🏎️💨', '⚽🔥', '⚙️🏗️', '🍽️🎊', '🧭☀️',
  '🧭❄️', '🏋️💧', '💰😈', '👑🦁', '😱🏃',
  // Medium 21-50
  '🌾🍞', '🏰📡', '🥤🎨', '🌾🍰', '💨🌫️',
  '🌊❄️', '🦴📖', '🌗🔄', '⛰️🫖', '👑📜',
  '📝🏫', '🌶️🧂', '🏆🎁', '☂️🌳', '❄️😌',
  '🦪💎', '🏔️🪵', '🔥🍗', '📈📱', '🌹👃',
  '💪🦍', '🙏⚖️', '🤷❓', '🎈💧', '🐝💉',
  '✊🧩', '🌱👀', '🐆🌙', '🤝📖', '😢⚰️',
  // Hard 51-100
  '🧹😤', '🦚☁️', '✂️🐑', '🏁⏳', '🔪😶',
  '🪟🧵', '⏰🏃', '👊🍺', '😴💤', '💪🦴',
  '🦆🎯', '🐈✨', '🤚🚪', '🃏🗡️', '💰🔐',
  '🌋🔥', '🐔💭', '☀️🏜️', '🧀🪓', '🌍💥',
  '😂🎉', '🤝✅', '💪🥩', '🎸🐔', '🪤🥁',
  '🌀🍦', '🏅⚔️', '🧺✋', '😰💀', '😏👃',
  '🏇🗡️', '📜✝️', '🎭🤡', '🌿🏡', '🪨⚡',
  '🕳️🚫', '✨💡', '🧣👵', '🧬📋', '🏛️🗝️',
  '⚔️🤝', '🏠📍', '📎✊', '😏🏆', '🍄💨',
  '🎭👤', '💑🌙', '🗡️💆', '🔧👁️', '🧱💧',
];

const _emojiAnswers = [
  // Easy 1-20
  'beach', 'teeth', 'blood', 'color', 'flood',
  'magic', 'smoke', 'crash', 'sleep', 'sweet',
  'speed', 'match', 'steel', 'feast', 'south',
  'north', 'sweat', 'greed', 'royal', 'panic',
  // Medium 21-50
  'grain', 'tower', 'blend', 'flour', 'vapor',
  'drift', 'spine', 'phase', 'steep', 'reign',
  'chalk', 'spice', 'prize', 'shade', 'chill',
  'pearl', 'cabin', 'roast', 'trend', 'scent',
  'brute', 'plead', 'shrug', 'bloat', 'sting',
  'grasp', 'stalk', 'prowl', 'sworn', 'grief',
  // Hard 51-100
  'grime', 'plume', 'shear', 'onset', 'blunt',
  'drape', 'haste', 'brawl', 'snore', 'elbow',
  'decoy', 'sleek', 'shove', 'rogue', 'stash',
  'erupt', 'brood', 'parch', 'wedge', 'quake',
  'mirth', 'vouch', 'brawn', 'pluck', 'snare',
  'swirl', 'valor', 'wrung', 'dread', 'sneer',
  'lance', 'creed', 'farce', 'shrub', 'cleft',
  'ditch', 'gleam', 'shawl', 'trait', 'relic',
  'guild', 'dwell', 'clasp', 'gloat', 'spore',
  'guise', 'tryst', 'scalp', 'gouge', 'grout',
];

/// Synonym: clue is a synonym word, answer is a 5-letter word
const _synonymClues = [
  // Easy 1-20
  'fast', 'large', 'happy', 'below', 'start',
  'incorrect', 'silent', 'glad', 'little', 'scared',
  'shop', 'odd', 'over', 'yell', 'friend',
  'simple', 'tale', 'filthy', 'ending', 'correct',
  // Medium 21-50
  'brave', 'grab', 'allow', 'carve', 'tired',
  'repair', 'aged', 'choose', 'ask', 'throw',
  'spin', 'bend', 'danger', 'leap', 'devour',
  'bony', 'accuse', 'frighten', 'ruin', 'foe',
  'rubbish', 'conceal', 'rage', 'rob', 'ascend',
  'talk', 'stiff', 'mock', 'decay', 'composed',
  // Hard 51-100
  'diminish', 'irritable', 'talent', 'forsake', 'burglar',
  'meager', 'cheerful', 'cherish', 'glorify', 'malice',
  'foolish', 'abundant', 'concede', 'criminal', 'devoted',
  'vulgar', 'uncanny', 'pinnacle', 'astute', 'candid',
  'delicate', 'detest', 'surplus', 'nimble', 'boast',
  'jeer', 'fleeting', 'shaggy', 'severe', 'wary',
  'radiant', 'unclear', 'tarnish', 'esteem', 'uproar',
  'gloomy', 'ponder', 'rebuff', 'opulent', 'trivial',
  'prowess', 'haughty', 'evade', 'barren', 'swindle',
  'furious', 'dreary', 'humble', 'pious', 'repeal',
];

const _synonymAnswers = [
  // Easy 1-20
  'quick', 'giant', 'jolly', 'under', 'begin',
  'wrong', 'quiet', 'merry', 'small', 'timid',
  'store', 'weird', 'above', 'shout', 'buddy',
  'basic', 'story', 'dirty', 'final', 'right',
  // Medium 21-50
  'noble', 'seize', 'grant', 'slice', 'weary',
  'amend', 'elder', 'elect', 'query', 'fling',
  'twirl', 'curve', 'peril', 'bound', 'gorge',
  'gaunt', 'blame', 'daunt', 'wreck', 'rival',
  'trash', 'cloak', 'wrath', 'steal', 'climb',
  'speak', 'rigid', 'scorn', 'erode', 'stoic',
  // Hard 51-100
  'abate', 'surly', 'craft', 'leave', 'crook',
  'scant', 'perky', 'adore', 'exalt', 'spite',
  'inane', 'ample', 'admit', 'felon', 'loyal',
  'crass', 'eerie', 'crest', 'sharp', 'frank',
  'frail', 'abhor', 'extra', 'agile', 'vaunt',
  'taunt', 'brief', 'hairy', 'harsh', 'leery',
  'aglow', 'vague', 'spoil', 'honor', 'furor',
  'moody', 'think', 'spurn', 'plush', 'petty',
  'might', 'proud', 'elude', 'stark', 'cheat',
  'livid', 'bleak', 'lowly', 'godly', 'annul',
];

/// Definition: clue is a short definition, answer is a 5-letter word
const _definitionClues = [
  // Easy 1-20
  'a bright shade of blue', 'a cereal grain for making flour',
  'cooked in an oven', 'a narrow passage between buildings',
  'to rest on the surface of water', 'footwear that protects your feet',
  'rain mixed with ice or snow', 'an informal name for a cat',
  'a low angry sound from an animal', 'transparent material in windows',
  'smooth and soft like silk', 'the main stem of a tree',
  'cloth worn around the neck', 'a female fox',
  'covered with or like sand', 'a series of events that repeats',
  'a group of singers', 'a stringed instrument larger than violin',
  'a shallow area of water', 'a soft round flat cap',
  // Medium 21-50
  'a deep narrow valley with steep sides', 'a spice used in curry dishes',
  'a unit of weight', 'a building where monks live',
  'a long narrow passage going down', 'a large animal with a horn',
  'a young female horse', 'a small bag for carrying money',
  'a seed produced by oak trees', 'the joint connecting foot and leg',
  'garment worn to protect clothing', 'the space under a roof',
  'a long seat for several people', 'the sharp edge of a knife',
  'linked metal rings in a line', 'the soft side of your face',
  'the front of your upper body', 'woven fabric used to make clothes',
  'a person who trains athletes', 'land along the edge of a sea',
  'a funny person or illustrated story', 'a place where legal trials occur',
  'a small narrow stream of water', 'an act that breaks the law',
  'products made from milk', 'an evil supernatural being',
  'a feeling of uncertainty', 'a mixture of flour and water',
  'a group of twelve', 'a channel that carries water away',
  // Hard 51-100
  'a serious play for theater', 'to die from being underwater',
  'covered with fine dry particles', 'keen and enthusiastic',
  'the same in amount or value', 'something that happens or takes place',
  'completely accurate and precise', 'a short story with a moral lesson',
  'strong belief or trust', 'a barrier around a yard',
  'a thin thread of material', 'a physical struggle between people',
  'the soft tissue of a body', 'thick with mist and hard to see',
  'to establish something new', 'the forward-facing part',
  'the edible product of a plant', 'already decided or specified',
  'green plants covering a lawn', 'a small group of trees',
  'a person who shows the way', 'unpleasantly rough or severe',
  'having great weight', 'a person or relating to people',
  'the quality of being amusing', 'perfect or most suitable',
  'a visual representation or picture', 'joints in the middle of your legs',
  'recognized or familiar to people', 'a tag with information on it',
  'a single thickness of material', 'permitted by law',
  'reasoning conducted by rules', 'a large country house with land',
  'the head of a city government', 'a hard shiny material like iron',
  'a small copy of something', 'a lesson about right and wrong',
  'an unwanted or loud sound', 'on the outside or external',
  'a thick soft sticky substance', 'the smallest unit of currency',
  'to throw a ball', 'relating to the north or south pole',
  'the ability to do or act', 'written language in ordinary form',
  'the rhythmic beating of arteries', 'a kingdom or area of activity',
  'a liquid served with food', 'a place where an event occurs',
];

const _definitionAnswers = [
  // Easy 1-20
  'azure', 'wheat', 'baked', 'alley', 'float',
  'shoes', 'sleet', 'kitty', 'growl', 'glass',
  'silky', 'trunk', 'scarf', 'vixen', 'sandy',
  'cycle', 'choir', 'viola', 'shoal', 'beret',
  // Medium 21-50
  'gorge', 'cumin', 'ounce', 'abbey', 'shaft',
  'rhino', 'filly', 'purse', 'acorn', 'ankle',
  'apron', 'attic', 'bench', 'blade', 'chain',
  'cheek', 'chest', 'cloth', 'coach', 'coast',
  'comic', 'court', 'creek', 'crime', 'dairy',
  'devil', 'doubt', 'dough', 'dozen', 'drain',
  // Hard 51-100
  'drama', 'drown', 'dusty', 'eager', 'equal',
  'event', 'exact', 'fable', 'faith', 'fence',
  'fiber', 'fight', 'flesh', 'foggy', 'found',
  'front', 'fruit', 'given', 'grass', 'grove',
  'guide', 'harsh', 'heavy', 'human', 'humor',
  'ideal', 'image', 'knees', 'known', 'label',
  'layer', 'legal', 'logic', 'manor', 'mayor',
  'metal', 'model', 'moral', 'noise', 'outer',
  'paste', 'penny', 'pitch', 'polar', 'power',
  'prose', 'pulse', 'realm', 'sauce', 'scene',
];



/// PictureWordle: describe with emojis, answer is a word
const _pictureClues = [
  // Easy 1-20
  '🐴', '❤️', '🍕', '🚂', '👑', '🍋', '🍬', '🐭', '🐍', '🌊',
  '🍑', '😇', '🍇', '👗', '🕐', '👢', '💀', '💰', '⛈️', '🌍',
  // Medium 21-50
  '🧚', '🦈', '⚔️', '🎹', '🤡', '🐼', '🐑', '🚛', '🐫', '🐌',
  '🪑', '🐨', '🍈', '🧱', '🍩', '🫒', '🧅', '🥭', '🥩', '🍣',
  '🔪', '🌷', '🐰', '🥓', '🐶', '🥗', '🐥', '🐦', '🍞', '☄️',
  // Hard 51-100
  '🧹', '🦑', '🪿', '🦦', '🛋️', '🧙', '🦙', '🦬', '🤖', '💂',
  '🦷', '🥯', '🛶', '🌶️', '🧪', '🦐', '🍄', '🐚', '📛', '🏹',
  '👨‍✈️', '🥷', '🦨', '🥄', '🦎', '🦛', '🪕', '🪈', '👩‍⚕️', '🧌',
  '🦥', '⛴️', '☮️', '🍝', '🍛', '🫐', '🔦', '📚', '🖌️', '🍁',
  '🪸', '🐟', '⏰', '🚨', '🧃', '😢', '🎬', '🖼️', '🏅', '🌎',
];

const _pictureAnswers = [
  // Easy 1-20
  'horse', 'heart', 'pizza', 'train', 'crown',
  'lemon', 'candy', 'mouse', 'snake', 'ocean',
  'peach', 'angel', 'grape', 'dress', 'clock',
  'boots', 'skull', 'money', 'storm', 'globe',
  // Medium 21-50
  'fairy', 'shark', 'sword', 'piano', 'clown',
  'panda', 'sheep', 'truck', 'camel', 'snail',
  'chair', 'koala', 'melon', 'brick', 'donut',
  'olive', 'onion', 'mango', 'steak', 'sushi',
  'knife', 'tulip', 'bunny', 'bacon', 'puppy',
  'salad', 'chick', 'robin', 'toast', 'comet',
  // Hard 51-100
  'broom', 'squid', 'goose', 'otter', 'couch',
  'witch', 'llama', 'bison', 'robot', 'guard',
  'tooth', 'bagel', 'canoe', 'chili', 'flask',
  'prawn', 'fungi', 'shell', 'badge', 'arrow',
  'pilot', 'ninja', 'skunk', 'spoon', 'gecko',
  'hippo', 'banjo', 'flute', 'nurse', 'troll',
  'sloth', 'ferry', 'peace', 'pasta', 'curry',
  'berry', 'torch', 'books', 'brush', 'maple',
  'coral', 'trout', 'alarm', 'siren', 'juice',
  'tears', 'movie', 'frame', 'medal', 'world',
];

String getAnswer(GameVariant variant, int level, {String locale = 'en'}) {
  final idx = (level - 1).clamp(0, 99);
  if (locale == 'da') {
    switch (variant) {
      case GameVariant.classicWordle:
        return classicWordsDa[idx];
      case GameVariant.numberle:
        return _numberleAnswers[idx]; // numbers are universal
      case GameVariant.emojiLink:
        return emojiAnswersDa[idx];
      case GameVariant.pictureWordle:
        return pictureAnswersDa[idx];
      case GameVariant.synonym:
        return synonymAnswersDa[idx];
      case GameVariant.definition:
        return definitionAnswersDa[idx];
    }
  }
  switch (variant) {
    case GameVariant.classicWordle:
      return _classicWords[idx];
    case GameVariant.numberle:
      return _numberleAnswers[idx];
    case GameVariant.emojiLink:
      return _emojiAnswers[idx];
    case GameVariant.pictureWordle:
      return _pictureAnswers[idx];
    case GameVariant.synonym:
      return _synonymAnswers[idx];
    case GameVariant.definition:
      return _definitionAnswers[idx];
  }
}

String? getClue(GameVariant variant, int level, {String locale = 'en'}) {
  final idx = (level - 1).clamp(0, 99);
  switch (variant) {
    case GameVariant.synonym:
      return locale == 'da' ? synonymCluesDa[idx] : _synonymClues[idx];
    case GameVariant.definition:
      return locale == 'da' ? definitionCluesDa[idx] : _definitionClues[idx];
    case GameVariant.pictureWordle:
      return locale == 'da' ? pictureCluesDa[idx] : _pictureClues[idx];
    case GameVariant.emojiLink:
      return locale == 'da' ? emojiCluesDa[idx] : _emojiClues[idx];
    default:
      return null;
  }
}

int getWordLength(GameVariant variant, int level, {String locale = 'en'}) {
  return getAnswer(variant, level, locale: locale).length;
}

int getMaxGuesses(GameVariant variant, int level) {
  switch (difficultyForLevel(level)) {
    case Difficulty.easy:
      return 6;
    case Difficulty.medium:
      return 5;
    case Difficulty.hard:
      return 4;
  }
}

String getAllowedChars(GameVariant variant, {String locale = 'en'}) {
  switch (variant) {
    case GameVariant.numberle:
      return '0123456789';
    default:
      if (locale == 'da') return 'abcdefghijklmnopqrstuvwxyzæøå';
      return 'abcdefghijklmnopqrstuvwxyz';
  }
}
