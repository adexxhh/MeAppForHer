import 'dart:math';

class TriviaQuestion {
  final String category;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String emote;

  TriviaQuestion({
    required this.category,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.emote,
  });
}

class TriviaData {
  static const String catLore = "The Adesh Lore";
  static const String catUs = "The Khadija Chapter";
  static const String catNerd = "The Nerd Files";

  static final List<TriviaQuestion> allQuestions = [
    // --- LORE (Personal Facts, Brother, Pop Culture) ---
    TriviaQuestion(category: catLore, question: "What is my *actual*, real date of birth?", options: ["July 27, 2004", "July 11, 2005", "February 11, 2005", "February 27, 2004"], correctIndex: 0, emote: "\uD83D\uDDD3\uFE0F"),
    TriviaQuestion(category: catLore, question: "Why do I have a 'fake' official birthday on my documents?", options: ["To get admitted into a school in Bhagalpur", "To meet engineering entrance exams criteria", "It was a clerical error", "To get admitted in Jalandhar"], correctIndex: 0, emote: "\uD83C\uDFE2"),
    TriviaQuestion(category: catLore, question: "How would I describe my relationship with my brother when we were kids?", options: ["He really didn't want me around him at all.", "We were completely inseparable.", "We fought constantly over video games.", "I was the bossy older brother."], correctIndex: 0, emote: "\uD83D\uDC66"),
    TriviaQuestion(category: catLore, question: "How has my brother changed towards me now that we are older?", options: ["He is crazy, helpful, and lets me be exactly who I am.", "He became super competitive with me.", "We grew apart.", "He constantly gives me unsolicited advice."], correctIndex: 0, emote: "\uD83E\uDD1D"),
    TriviaQuestion(category: catLore, question: "Under what specific condition do I actually enjoy going out and partying?", options: ["Only when my brother is around.", "Only if it's a tech meetup.", "Only if you (Khadija) force me.", "Only if there is free food."], correctIndex: 0, emote: "\uD83C\uDF89"),
    TriviaQuestion(category: catLore, question: "Before moving and dealing with the school admission chaos, where was I originally born?", options: ["Madhuban", "Bhagalpur", "Patna", "Darbhanga"], correctIndex: 0, emote: "\uD83C\uDFE5"),
    TriviaQuestion(category: catLore, question: "I grew up a die-hard John Cena fan. What was my most infamous wrestling moment?", options: ["I broke a bed attempting an AA on my brother.", "I broke an arm attempting a Chokeslam.", "I broke a table with an AA.", "I broke a bed doing a Swanton Bomb."], correctIndex: 0, emote: "\uD83E\uDD3C\u200D\u2642\uFE0F"),
    TriviaQuestion(category: catLore, question: "What is my absolute favorite movie, and favorite on-screen couple?", options: ["The Amazing Spider-Man; Peter & Gwen", "Spider-Man: No Way Home; Peter & MJ", "The Amazing Spider-Man; Peter & MJ", "The Dark Knight; Bruce & Rachel"], correctIndex: 0, emote: "\uD83D\uDD77\uFE0F"),
    TriviaQuestion(category: catLore, question: "What is the exact title of the latest Hindi novel I read?", options: ["Gunahon Ka Devta by Dharamveer Bharti", "Madhushala by Harivansh Rai Bachchan", "Godan by Munshi Premchand", "Raag Darbari by Shrilal Shukla"], correctIndex: 0, emote: "\uD83D\uDCD6"),
    TriviaQuestion(category: catLore, question: "How did I actually get the nickname 'Bittu'?", options: ["My Brother named me", "My Mom started calling me that", "My Dad gave it to me", "My Grandparents chose it"], correctIndex: 0, emote: "\uD83D\uDC76"),

    // --- US (Relationship, Khadija Chapter) ---
    TriviaQuestion(category: catUs, question: "What is the specific defining reason I always come back to you?", options: ["Because you let me be exactly who I am, and accepted me for it.", "Because you understand my philosophical questions.", "Because you motivate me to chase my tech career.", "Because you match my extroverted energy."], correctIndex: 0, emote: "\uD83D\uDC96"),
    TriviaQuestion(category: catUs, question: "What is my absolute favorite way to spend a lazy Sunday with you?", options: ["Binge-watching a cheesy Netflix rom-com in our pajamas.", "Going out for a long drive.", "Sitting in comfortable silence while I code.", "Taking you out shopping all day."], correctIndex: 0, emote: "\uD83D\uDECF\uFE0F"),
    TriviaQuestion(category: catUs, question: "If I am having a terrible day, what is the single fastest way to fix my mood?", options: ["Buying me my favorite food.", "You giving me a hug and letting me vent.", "Sending me a funny meme.", "Leaving me completely alone in a dark room."], correctIndex: 0, emote: "\uD83C\uDF54"),
    TriviaQuestion(category: catUs, question: "If I had to describe you (Khadija) to a stranger in one word, what would I use?", options: ["My peace.", "My anchor.", "My muse.", "My partner-in-crime."], correctIndex: 0, emote: "\uD83D\uDD4A\uFE0F"),
    TriviaQuestion(category: catUs, question: "What is the one thing you do that instantly makes me melt?", options: ["The way you smile when you're genuinely laughing at my jokes.", "When you randomly text me to tell me you're proud.", "How you remember tiny details.", "When you defend me in an argument."], correctIndex: 0, emote: "\uD83E\uDD60"),
    TriviaQuestion(category: catUs, question: "What was my *exact* first thought the very first time I saw you?", options: ["She looks like she reads good books.", "She is way out of my league.", "I need to go talk to her right now.", "I hope she doesn't notice me staring."], correctIndex: 0, emote: "\uD83D\uDCDA"),
    TriviaQuestion(category: catUs, question: "When we get into a stupid argument, who is usually the first one to break the silence?", options: ["We both awkwardly start talking at the same time.", "Me (Adesh)", "You (Khadija)", "We send each other a meme instead."], correctIndex: 0, emote: "\uD83D\uDE48"),
    TriviaQuestion(category: catUs, question: "If I had to delete all the apps on my phone except for three, I would keep WhatsApp, Spotify, and...", options: ["My gallery", "GitHub", "Netflix", "VS Code"], correctIndex: 0, emote: "\uD83D\uDDBC\uFE0F"),
    TriviaQuestion(category: catUs, question: "What was the defining feature of my childhood relationship with my mother?", options: ["Spending hours around her, just telling her tales.", "Reading my detective novels aloud to her.", "Watching wrestling with her.", "Having her help me write my creative stories."], correctIndex: 0, emote: "\uD83D\uDC69\u200D\uD83D\uDC66"),
    TriviaQuestion(category: catUs, question: "What is the ultimate cheat code to make me fall asleep?", options: ["Scratching my back", "Playing with my hair", "Holding my hand", "Massaging my head"], correctIndex: 0, emote: "\uD83D\uDE34"),

    // --- NERD (Mind, Tech, Engineering) ---
    TriviaQuestion(category: catNerd, question: "I am currently studying Civil Engineering. Why did I actually pick this branch?", options: ["I purely just wanted to get into an NIT, regardless of the branch.", "I thought it would leave me free time to code.", "My parents pressured me into a core field.", "I actually wanted it initially."], correctIndex: 0, emote: "\uD83C\uDFD7\uFE0F"),
    TriviaQuestion(category: catNerd, question: "I’ve been trying to break into tech. What is the biggest thing I’ve done to prove my hustle?", options: ["Leading the biggest tech club (GDGC) and organizing HackMol.", "Landing a remote tech internship.", "Winning a national-level hackathon.", "Building an app for the college administration."], correctIndex: 0, emote: "\uD83D\uDCBB"),
    TriviaQuestion(category: catNerd, question: "I prefer DC over Marvel. What is my exact reasoning for this?", options: ["I find DC heroes more reasonable and grounded than Marvel's alien-fighting teams.", "I think DC's detective storylines appeal to Sherlock Holmes fans.", "DC's cinematic universe is darker.", "I actually grew up reading DC comics only."], correctIndex: 0, emote: "\uD83E\uDDB8\u200D\u2642\uFE0F"),
    TriviaQuestion(category: catNerd, question: "When I started reading in 9th grade, how exactly did I kick off my journey?", options: ["I started with Detective Fiction and binge-read Sherlock Holmes.", "I started with classic romantic literature.", "I started with non-fiction tech biographies.", "I started with Hindi novels."], correctIndex: 0, emote: "\uD83D\uDD0D"),
    TriviaQuestion(category: catNerd, question: "What fascinates me the absolute most about the world?", options: ["Understanding the behavior of people around me and asking deep questions.", "Figuring out how to manipulate narratives.", "Understanding philosophical meanings in literature.", "Learning how algorithms dictate choices."], correctIndex: 0, emote: "\uD83C\uDF0E"),
    TriviaQuestion(category: catNerd, question: "I call myself a 'Symbiote'. What does that mean to me?", options: ["I thrive on making meaningful connections and feed off that energy.", "I attach myself to the smartest people.", "I drain energy from parties.", "I blend into any social group seamlessly."], correctIndex: 0, emote: "\uD83D\uDD78\uFE0F"),
    TriviaQuestion(category: catNerd, question: "My favorite quote is by the Greek philosopher Heraclitus. Which is it?", options: ["No man ever steps in the same river twice, for it's not the same river and he's not the same man.", "There is nothing permanent except change.", "The only constant in life is change.", "We suffer more often in imagination than in reality."], correctIndex: 0, emote: "\uD83D\uDCDC"),
    TriviaQuestion(category: catNerd, question: "My most annoying (but endearing) habit when I am hyper-focused on coding is:", options: ["I completely forget to text back or check my phone for hours.", "I talk to myself out loud.", "I drink an unhealthy amount of coffee.", "I refuse to sleep until the bug is fixed."], correctIndex: 0, emote: "\uD83D\uDE35\u200D\uD83D\uDCAB"),
    TriviaQuestion(category: catNerd, question: "Which of these things is currently my biggest career frustration?", options: ["I haven't landed a big tech internship yet despite leading clubs.", "I am failing my Civil core classes.", "Nobody uses the apps I build.", "I am completely burned out from HackMol."], correctIndex: 0, emote: "\uD83D\uDE23"),
    TriviaQuestion(category: catNerd, question: "What is the real reason I don't follow or play any major sports?", options: ["I'm just not that good at them and have been a nerd my whole life.", "I broke a bone once.", "I find sports completely boring.", "My parents never let me play outside."], correctIndex: 0, emote: "\uD83E\uDD13"),
  ];

  static List<TriviaQuestion> getQuestionsForCategory(String category) {
    var qs = allQuestions.where((q) => q.category == category).toList();
    qs.shuffle();
    return qs.take(5).map((q) {
      String correctAnswer = q.options[q.correctIndex];
      List<String> shufflableOptions = List.from(q.options);
      shufflableOptions.shuffle();
      int newCorrectIndex = shufflableOptions.indexOf(correctAnswer);

      return TriviaQuestion(
        category: q.category,
        question: q.question,
        options: shufflableOptions,
        correctIndex: newCorrectIndex,
        emote: q.emote,
      );
    }).toList();
  }
}
