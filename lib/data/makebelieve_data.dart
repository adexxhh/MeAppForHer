import 'dart:math';

class MakebelieveData {
  static const List<String> cities = [
    "Paris, France", "Tokyo, Japan", "New York, USA", "Santorini, Greece", "Kyoto, Japan",
    "Venice, Italy", "Rome, Italy", "Prague, Czechia", "Barcelona, Spain", "Vienna, Austria",
    "Amsterdam, Netherlands", "Istanbul, Turkey", "Budapest, Hungary", "Florence, Italy", "London, UK",
    "Sydney, Australia", "Cape Town, South Africa", "Rio de Janeiro, Brazil", "Buenos Aires, Argentina", "Reykjavik, Iceland",
    "Dubai, UAE", "Singapore", "Seoul, South Korea", "Hong Kong", "Bangkok, Thailand",
    "Lisbon, Portugal", "Berlin, Germany", "Munich, Germany", "Zurich, Switzerland", "Geneva, Switzerland",
    "Lucerne, Switzerland", "Stockholm, Sweden", "Copenhagen, Denmark", "Oslo, Norway", "Helsinki, Finland",
    "Edinburgh, Scotland", "Dublin, Ireland", "Bruges, Belgium", "Antwerp, Belgium", "Salzburg, Austria",
    "Dubrovnik, Croatia", "Split, Croatia", "Marrakech, Morocco", "Cairo, Egypt", "Nairobi, Kenya",
    "Zanzibar, Tanzania", "Cape Town, South Africa", "Cartagena, Colombia", "Medellin, Colombia", "Lima, Peru",
    "Cusco, Peru", "Santiago, Chile", "Valparaiso, Chile", "Havana, Cuba", "San Juan, Puerto Rico",
    "Mexico City, Mexico", "Cancun, Mexico", "Banff, Canada", "Vancouver, Canada", "Quebec City, Canada",
    "Montreal, Canada", "San Francisco, USA", "New Orleans, USA", "Chicago, USA", "Honolulu, USA",
    "Maui, USA", "Queenstown, New Zealand", "Auckland, New Zealand", "Bora Bora, French Polynesia", "Fiji",
    "Maldives", "Seychelles", "Mauritius", "Bali, Indonesia", "Phuket, Thailand",
    "Chiang Mai, Thailand", "Hoi An, Vietnam", "Hanoi, Vietnam", "Siem Reap, Cambodia", "Luang Prabang, Laos",
    "Taipei, Taiwan", "Macau", "Beijing, China", "Shanghai, China", "Chengdu, China",
    "Saint Petersburg, Russia", "Moscow, Russia", "Krakow, Poland", "Warsaw, Poland", "Bucharest, Romania",
    "Sofia, Bulgaria", "Athens, Greece", "Mykonos, Greece", "Valletta, Malta", "Nicosia, Cyprus",
    "Jerusalem, Israel", "Tel Aviv, Israel", "Amman, Jordan", "Petra, Jordan", "Beirut, Lebanon"
  ];

  static const List<String> occupations = [
    "Master Chocolatier", "Secret Intelligence Agent", "Bestselling Mystery Author", "Astronaut", "Marine Biologist",
    "Fighter Pilot", "Hollywood Director", "Vintage Bookshop Owner", "Deep Sea Treasure Hunter", "World-Class Sommelier",
    "Rogue Archaeologist", "AI Robotics Inventor", "Broadway Lead Actor", "Undercover Detective", "Wildlife Photographer",
    "Exotic Animal Veterinarian", "Cybersecurity Hacker", "Luxury Yacht Captain", "International Spy", "Time Travel Researcher",
    "Bounty Hunter", "Symphony Conductor", "Antique Art Appraiser", "Haute Couture Fashion Designer", "Formula 1 Driver",
    "Space Station Commander", "Superyacht Designer", "Paranormal Investigator", "Professional Poker Player", "Quantum Physicist",
    "Volcanologist", "Cordon Bleu Executive Chef", "Boutique Hotel Heiress", "Professional Stunt Double", "Himalayan Mountaineer",
    "Rival Mafia Boss", "CIA Cryptanalyst", "Deep Woods Park Ranger", "Investigative Journalist", "Botanical Garden Curator",
    "Forensic Anthropologist", "Secret Society Leader", "Renegade Pirate Captain", "Royal Guard Commander", "Palace Architect",
    "Astrophysicist", "Diplomatic Ambassador", "Billionaire Tech Mogul", "Illusionist & Magician", "Antique Clockmaker",
    "Professional Jewel Thief", "Tattoo Artist to the Stars", "Elite Bodyguard", "Perfumer in Grasse", "Amnesiac Royalty",
    "Gladiator Champion", "Tea Sommelier", "Private Island Caretaker", "Lighthouse Keeper", "Helicopter Rescue Pilot",
    "Renowned Sculptor", "Ghostwriter for Celebrities", "Rare Plant Smuggler", "Jazz Club Owner", "Midnight Radio Host",
    "Astronomy Professor", "Professional Matchmaker", "Stowaway on a Spaceship", "Head of a Ninja Clan", "Gourmet Food Critic",
    "Elven Archer", "Cyberpunk Hacker", "Intergalactic Cartographer", "Dragon Tamer", "Wandmaker",
    "Ice Cream Flavour Guru", "Cat Cafe Proprietor", "Librarian of Forbidden Books", "Professional Cuddler", "Dog Whisperer",
    "Vineyard Owner", "Polar Explorer", "Storm Chaser", "Meteorologist", "Meteorite Hunter",
    "Neon Sign Artisan", "Underground Club Promoter", "Professional Mermaid", "Ice Sculptor", "Trapeze Artist",
    "Circus Ringmaster", "Fire Dancer", "Motorcycle Mechanic", "Vintage Car Restorer", "Hot Air Balloon Pilot",
    "Professional Surfer", "Snowboard Instructor", "Yoga Guru in Bali", "Zen Monastery Monk", "Martial Arts Grandmaster"
  ];

  static List<String> getRandomCities(int count) {
    var copy = List<String>.from(cities);
    copy.shuffle();
    return copy.take(count).toList();
  }

  static List<String> getRandomOccupations(int count) {
    var copy = List<String>.from(occupations);
    copy.shuffle();
    return copy.take(count).toList();
  }

  static String getCityImageUrl(String cityName) {
    // We use a deterministic seed based on city name for consistent beautiful placeholder images
    final encoded = Uri.encodeComponent(cityName);
    // Picsum seed allows random landscape architecture visually appealing photos
    return "https://picsum.photos/seed/$encoded/600/800";
  }

  static String generateNarrative(String city, String hisJob, String herJob) {
    final List<String> templates = [
      "The sun casts a golden glow over $city, painting the sky in breathless shades of pink and orange. You've spent the entire day thriving as a renowned $herJob, making decisions that mesmerize everyone around you. You finally return to your spectacular penthouse. The moment you walk through the door, the scent of your favorite dinner hits you. Adesh emerges from the kitchen. While the world reveres him as a fearsome $hisJob, to you, he's just the man who remembers exactly how you like your coffee and sings off-key to make you smile.\n\nHe walks over, gently removing your coat, and pulls you into an embrace so tight the rest of the world just fades away. 'Rough day, my queen?' he whispers playfully against your neck. After dinner, the two of you climb up to the rooftop terrace. Wrapped together under a heavy blanket, watching the twinkling lights of $city spread out infinitely below, you realize that out of all the success and fame, the absolute best part of your life is right here in his arms. It’s a perfect, flawless happy ending.",
      
      "Rain falls softly against the massive glass windows of your high-rise studio in $city. A gentle jazz melody plays in the background. It is late, and you are deeply focused, putting the final touches on your latest breakthrough as a world-class $herJob. The door clicks open. Adesh steps in. He looks exhausted from a chaotic mission operating as the city's top $hisJob, his hair perfectly messy, jacket slung over one shoulder.\n\nBut the moment his eyes find yours, a wide, genuine smile spreads across his face. All his exhaustion seems to vanish. He walks up behind your chair, leans down, and places a soft kiss on your temple. 'You're working too hard, beautiful,' he murmurs. He gently closes your laptop, defying your playful protests, and scoops you up effortlessly. He carries you to the couch, makes two mugs of hot tea, and sits with you. Listening to the rain on the glass and his steady heartbeat, you know this is exactly where you belong. A perfectly peaceful, happily ever after.",
      
      "It is the grandest night $city has ever seen. The crystal chandeliers of the ballroom gleam as you make your entrance. You are stunning, commanding the entire room's attention, carrying the immense prestige of your title as a legendary $herJob. Cameras flash, but you only have eyes for one person. Across the room stands Adesh. Despite being the most dangerous and elusive $hisJob in the hemisphere, tonight, he is wearing a sharp, tailored tuxedo just for you.\n\nHe smoothly navigates the crowded room, his eyes never leaving yours. He bows slightly, offering his hand. 'May I have this dance, or are you too famous for me now?' he teases. You take his hand, and as the orchestra plays, the two of you glide across the floor. In his arms, nothing else exists. The music, the city, the crowd—they all disappear. He spins you, catches you perfectly, and whispers that he will love you until the end of time. It is a fairy tale come true.",
      
      "The crisp morning air of $city fills your lungs as you sip your espresso at a quaint corner café. As a fiercely independent $herJob, you cherish these quiet mornings. Suddenly, a sleek black car pulls up to the curb. The door opens, and Adesh steps out, looking incredibly handsome in his signature $hisJob attire. He spots you, completely ignoring his demanding schedule, and walks over with a bouquet of your absolute favorite flowers.\n\n'I had a meeting,' he says, handing you the bouquet, 'but then I realized I hadn't seen your smile yet today, and that was a priority.' He pulls up a chair, stealing a sip of your coffee and making you laugh so hard your stomach hurts. For the entire morning, the brilliant $herJob and the untouchable $hisJob are just two people hopelessly, deeply in love, talking about the future, counting their blessings, and knowing they already have a perfect happy ending.",
      
      "Deep in the heart of $city, hidden away from the prying eyes of the press, lies your private sanctuary. You are taking a rare day off from being the city's most brilliant $herJob. You hear a loud crash from the kitchen. You walk in to find Adesh—the incredibly intimidating and successful $hisJob—covered in flour, trying (and failing) to bake a cake for your anniversary.\n\nHe looks up, sheepishly wiping flour off his cheek. 'It was supposed to be a surprise,' he laughs. You can't help but absolutely melt. You walk over, wipe the flour off his nose, and pull him into a kiss that tastes like sugar and pure happiness. Instead of the cake, you order pizza, build a massive blanket fort in the living room, and spend the entire night watching terrible movies and laughing until you can't breathe. It isn't a glamorous Hollywood ending, but to you both, it is infinitely better. It is pure, unfiltered love."
    ];

    templates.shuffle();
    return templates.first;
  }
}
