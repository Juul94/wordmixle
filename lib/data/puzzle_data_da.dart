// Danish puzzle data for all 6 variants, 100 levels each.

const classicWordsDa = [
  // Easy 1-20
  'æble', 'huset', 'vande', 'jorde', 'lyser', 'musik', 'danse', 'brøde',
  'drømt', 'skyer', 'stene', 'flamm', 'bloms', 'smile', 'plant', 'natte',
  'dronr', 'flode', 'tigre', 'klokk',
  // Medium 21-50
  'hjern', 'skake', 'krane', 'dværg', 'ørnen', 'frost', 'spøge', 'honni',
  'elfnb', 'joker', 'knæle', 'månen', 'sumpe', 'roman', 'kresl', 'prism',
  'dækkn', 'radar', 'solnr', 'torne', 'ultra', 'hvælv', 'hvale', 'xenon',
  'yacht', 'zebra', 'brand', 'klint', 'delta', 'gløde',
  // Hard 51-100
  'smedj', 'glyfe', 'havel', 'intro', 'juvel', 'karma', 'klink', 'elgne',
  'nexus', 'omega', 'blylr', 'opgav', 'rustr', 'belejr', 'fredn', 'enhed',
  'kraft', 'hånde', 'iltne', 'hæver', 'zilch', 'dueli', 'frisk', 'klamr',
  'undgå', 'eksil', 'flint', 'slibe', 'hejse', 'input', 'jumbo', 'evner',
  'lymfe', 'fugti', 'puffe', 'optik', 'abore', 'kvote', 'kamme', 'skulk',
  'frist', 'tilrn', 'livli', 'piske', 'udlan', 'gæren', 'zoner', 'bolig',
  'lager', 'sprød',
];

const emojiCluesDa = [
  // Easy 1-20
  '🍎🌳', '🏠🔑', '💧🌊', '🌍🌿', '💡☀️',
  '🎵🎶', '💃🕺', '🍞🧈', '💭😴', '☁️🌤️',
  '🪨⛰️', '🔥🕯️', '🌸🌺', '😊😁', '🌱🌿',
  '🌙⭐', '👸👑', '🏞️💧', '🐅🐾', '⌚⏰',
  // Medium 21-50
  '🧠💭', '♟️🏆', '🏗️🔧', '🧝‍♂️📏', '🦅🪶',
  '❄️🥶', '👻💀', '🍯🐝', '🦷🪥', '🃏😈',
  '🧎🙏', '🌕🌑', '🏝️🌊', '📖📚', '🌀🔄',
  '🔺📐', '🧵🪡', '📡🛰️', '☀️🔆', '🌹❤️',
  '⚡💥', '🏦💰', '🐋🌊', '⚛️🔬', '🛥️⛵',
  '🦓🖤', '🔥🌋', '🏔️⛰️', '📐📏', '🔶🟧',
  // Hard 51-100
  '⚒️🔨', '🔣✏️', '🏡🌳', '📝✍️', '💎💍',
  '☸️🧘', '🔒🔑', '🫎🦌', '🔗⛓️', '🌀💫',
  '🔧⚙️', '❓🤔', '🦀🌊', '🏰⚔️', '🕊️☮️',
  '🔄🔃', '💪🏋️', '✋🖐️', '⚗️🧪', '🌾🌻',
  '📦🎁', '🎯🏹', '🔴⭕', '⚓🚢', '🧪🔬',
  '🕸️🕷️', '🔔🎵', '🪨💎', '🌪️💨', '🪤🐭',
  '🧲🧷', '🏛️🏺', '🎭🎪', '🪶🖊️', '🧊❄️',
  '👁️👀', '🪜📶', '🧿👁️', '💫⭐', '🪐🌌',
  '🍄🌲', '🪞🔍', '🧶🪡', '🪵🌲', '📿🧵',
  '🧬🔬', '🪸🌊', '🫧💧', '🦴🐕', '🪺🐣',
];

const emojiAnswersDa = classicWordsDa;

const pictureCluesDa = [
  '🍎', '🏠', '💧', '🌍', '💡', '🎵', '💃', '🍞', '💭', '☁️',
  '🪨', '🔥', '🌸', '😊', '🌱', '🌙', '👸', '🏞️', '🐅', '⌚',
  '🧠', '♟️', '🏗️', '🧝', '🦅', '❄️', '👻', '🍯', '🦷', '🃏',
  '🧎', '🌕', '🏝️', '📖', '🌀', '🔺', '🧵', '📡', '☀️', '🌹',
  '⚡', '🏦', '🐋', '⚛️', '🛥️', '🦓', '🔥', '🏔️', '📐', '🔶',
  '⚒️', '🔣', '🏡', '📝', '💎', '☸️', '🔒', '🫎', '🔗', '🌀',
  '🔧', '❓', '🦀', '🏰', '🕊️', '🔄', '💪', '✋', '⚗️', '🌾',
  '📦', '🎯', '🔴', '⚓', '🧪', '🕸️', '🔔', '🪨', '🌪️', '🪤',
  '🧲', '🏛️', '🎭', '🪶', '🧊', '👁️', '🪜', '🧿', '💫', '🪐',
  '🍄', '🪞', '🧶', '🪵', '📿', '🧬', '🪸', '🫧', '🦴', '🪺',
];

const pictureAnswersDa = classicWordsDa;

const synonymCluesDa = [
  // Easy 1-20
  'fryd', 'harme', 'styrke', 'opdage', 'sørgelig',
  'stille', 'smide', 'høre', 'frygt', 'venlig',
  'oprigtig', 'kraftig', 'forskrækket', 'indtage', 'færdes',
  'skynde', 'spærre', 'alene', 'uægte', 'pænt',
  // Medium 21-50
  'forsøge', 'bestemme', 'sanke', 'styrte', 'knække',
  'bevare', 'klatre', 'danne', 'gemme', 'tøve',
  'tabe', 'klippe', 'smadre', 'skælve', 'anvende',
  'brokke', 'hæve', 'le', 'genere', 'bedrage',
  'frelse', 'tydeligt', 'slappe', 'rode', 'gro',
  'opføre', 'lede', 'trygle', 'ødelægge', 'skidt',
  // Hard 51-100
  'usikkerhed', 'rømning', 'rasende', 'grådig', 'myrde',
  'undertrykke', 'skride', 'råbe', 'hovere', 'stivne',
  'vaske', 'pågribe', 'træffe', 'snæver', 'knytte',
  'dreje', 'hugge', 'sky', 'henrykke', 'friste',
  'lovprise', 'plyndre', 'provokere', 'nøle', 'banke',
  'fortære', 'visdom', 'forræderi', 'gengælde', 'beskytte',
  'blottet', 'hungre', 'hæsligt', 'diset', 'opmærksom',
  'stride', 'påstå', 'ly', 'blæse', 'drive',
  'nydelig', 'hyle', 'falme', 'sludder', 'omtale',
  'lindre', 'følge', 'betvinge', 'nedtone', 'hovmodig',
];

const synonymAnswersDa = [
  // Easy 1-20
  'glæde', 'vrede', 'kraft', 'finde', 'trist',
  'rolig', 'kaste', 'lytte', 'angst', 'flink',
  'ærlig', 'stærk', 'bange', 'spise', 'rejse',
  'haste', 'lukke', 'ensom', 'falsk', 'smukt',
  // Medium 21-50
  'prøve', 'vælge', 'samle', 'falde', 'bryde',
  'holde', 'stige', 'skabe', 'spare', 'vente',
  'miste', 'skære', 'knuse', 'ryste', 'bruge',
  'klage', 'løfte', 'grine', 'plage', 'snyde',
  'redde', 'klart', 'hvile', 'grave', 'vokse',
  'bygge', 'styre', 'tigge', 'skade', 'snavs',
  // Hard 51-100
  'tvivl', 'flugt', 'arrig', 'grisk', 'dræbe',
  'kvæle', 'glide', 'brøle', 'prale', 'fryse',
  'rense', 'fange', 'ramme', 'stram', 'binde',
  'vende', 'fælde', 'undgå', 'fryde', 'lokke',
  'hylde', 'hærge', 'tirre', 'dvæle', 'dunke',
  'sluge', 'kløgt', 'svigt', 'hævne', 'skåne',
  'nøgen', 'sulte', 'grimt', 'tåget', 'vågen',
  'kæmpe', 'hævde', 'skjul', 'puste', 'flyde',
  'yndig', 'skrig', 'visne', 'vrøvl', 'nævne',
  'dulme', 'spore', 'tæmme', 'dæmpe', 'stolt',
];

const definitionCluesDa = [
  // Easy 1-20
  'en lys blå farve', 'et korn til mel',
  'tilberedt i ovn', 'en smal passage mellem bygninger',
  'at hvile på vandets overflade', 'fodtøj der beskytter dine fødder',
  'regn blandet med is', 'et kælenavn for en kat',
  'en lav vred lyd fra et dyr', 'gennemsigtigt materiale i vinduer',
  'glat og blød som silke', 'hovedstammen på et træ',
  'stof båret om halsen', 'en hunræv',
  'dækket med sand', 'en serie begivenheder der gentages',
  'en gruppe sangere', 'strygeinstrument større end violin',
  'et lavvandet område', 'en blød rund flad kasket',
  // Medium 21-50
  'en dyb snæver dal', 'et krydderi brugt i karry',
  'en vægtenhed', 'en bygning hvor munke bor',
  'en lang snæver nedadgående passage', 'et stort dyr med horn',
  'en ung hunhest', 'en lille taske til penge',
  'et frø fra egetræer', 'leddet mellem fod og ben',
  'tøj der beskytter beklædning', 'rummet under taget',
  'en lang siddeplads', 'den skarpe del af en kniv',
  'metal ringe forbundet i en linje', 'den bløde side af ansigtet',
  'foran på overkroppen', 'vævet stof til tøj',
  'en person der træner atleter', 'land langs havets kant',
  'en sjov person eller tegneserie', 'et sted hvor retssager foregår',
  'en lille smal vandstrøm', 'en handling der bryder loven',
  'produkter lavet af mælk', 'et ondt overnaturligt væsen',
  'en følelse af usikkerhed', 'en blanding af mel og vand',
  'en gruppe på tolv', 'en kanal der bærer vand væk',
  // Hard 51-100
  'et seriøst teaterstykke', 'at dø af at være under vand',
  'dækket med fine tørre partikler', 'ivrig og entusiastisk',
  'det samme i mængde eller værdi', 'noget der sker eller finder sted',
  'fuldstændig nøjagtig og præcis', 'en kort historie med en moral',
  'stærk tro eller tillid', 'en barriere rundt om en gård',
  'en tynd tråd af materiale', 'en fysisk kamp mellem mennesker',
  'det bløde væv i en krop', 'tæt med tåge og svært at se',
  'at etablere noget nyt', 'den fremadvendte del',
  'den spiselige del af en plante', 'allerede besluttet eller specificeret',
  'grønne planter på en plæne', 'en lille gruppe træer',
  'en person der viser vejen', 'ubehageligt hård eller streng',
  'med stor vægt', 'en person eller vedrørende folk',
  'evnen til at være morsom', 'perfekt eller mest passende',
  'en visuel fremstilling', 'led i midten af dine ben',
  'genkendt eller velkendt', 'et mærke med information',
  'et enkelt lag af materiale', 'tilladt ved lov',
  'tænkning efter regler', 'et stort landsted med jord',
  'lederen af en byregering', 'et hårdt skinnende materiale',
  'en lille kopi af noget', 'en lektie om rigtigt og forkert',
  'en uønsket eller høj lyd', 'på ydersiden eller ekstern',
  'en tyk blød klæbrig substans', 'den mindste møntenhed',
  'at kaste en bold', 'vedrørende nord- eller sydpolen',
  'evnen til at handle', 'skrevet sprog i almindelig form',
  'den rytmiske banken af arterier', 'et rige eller aktivitetsområde',
  'en væske serveret med mad', 'et sted hvor en begivenhed sker',
];

const definitionAnswersDa = [
  // Easy 1-20
  'azurb', 'hvede', 'bagen', 'smøge', 'flydt',
  'skoen', 'sludi', 'misen', 'knurr', 'glasr',
  'silke', 'stamm', 'tørkl', 'hunrv', 'sande',
  'cyklu', 'koret', 'bratc', 'revle', 'baskr',
  // Medium 21-50
  'kløft', 'kumin', 'unser', 'klost', 'skakt',
  'næshr', 'følho', 'punge', 'agern', 'ankls',
  'forki', 'loftr', 'bænke', 'blads', 'kæden',
  'kinds', 'brysk', 'stofr', 'trænr', 'kyste',
  'komik', 'retsl', 'bækkn', 'forbr', 'mejri',
  'djævl', 'tvivl', 'dejgs', 'dusin', 'afløb',
  // Hard 51-100
  'draml', 'drukn', 'støvt', 'ivrig', 'liget',
  'hænde', 'eksak', 'fabel', 'trosk', 'hegne',
  'fiber', 'kampe', 'kødel', 'tåget', 'grundl',
  'front', 'frugt', 'given', 'græsn', 'lunde',
  'leder', 'barsk', 'tunge', 'menne', 'humor',
  'ideel', 'bilde', 'knæer', 'kendte', 'mærkr',
  'laget', 'lovlr', 'logik', 'godse', 'borgm',
  'metal', 'model', 'moral', 'støjen', 'ydrel',
  'klise', 'ørens', 'kaste', 'polær', 'kraft',
  'prosa', 'pulsr', 'riget', 'sovse', 'scene',
];


