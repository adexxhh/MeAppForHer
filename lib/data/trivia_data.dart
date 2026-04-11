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
  static const String catNerd = "The Nerd Files";
  static const String catUs = "The Khadija Chapter";

  static final List<TriviaQuestion> allQuestions = [
    // --- LORE ---
    TriviaQuestion(
      category: catLore,
      question: "What is my *actual*, real date of birth?",
      options: [
        "July 27, 2004",
        "July 11, 2005",
        "February 11, 2005",
        "February 27, 2004"
      ],
      correctIndex: 0,
      emote: "\uD83D\uDC76" // Baby
    ),
    TriviaQuestion(
      category: catLore,
      question: "Why do I have a 'fake' official birthday on my documents?",
      options: [
        "To get admitted into a school in Bhagalpur because I was a mid-year baby.",
        "So I could meet the age criteria for my engineering entrance exams.",
        "It was a clerical error in my hometown that we just never bothered to fix.",
        "To get admitted into a school in Jalandhar when we moved."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDCDC" // Scroll/Document
    ),
    TriviaQuestion(
      category: catLore,
      question: "I grew up a die-hard John Cena fan. What was my most infamous wrestling moment?",
      options: [
        "I broke a bed attempting an AA (Attitude Adjustment) on my brother.",
        "I broke my brother's arm attempting a Chokeslam on him.",
        "I broke a table attempting an AA on my brother.",
        "I broke a bed attempting a Swanton Bomb off the dresser."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDD3C\u200D\u2642\uFE0F" // Wrestler
    ),
    TriviaQuestion(
      category: catLore,
      question: "How would I describe my relationship with my brother when we were kids?",
      options: [
        "He really didn't want me around him at all.",
        "We were completely inseparable and did everything together.",
        "We fought constantly over video games and TV time.",
        "I was the bossy older brother who told him what to do."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDE44" // Rolling eyes
    ),
    TriviaQuestion(
      category: catLore,
      question: "How has my brother changed towards me now that we are older?",
      options: [
        "He is crazy, helpful, and lets me be exactly who I am.",
        "He became super competitive with me regarding our careers.",
        "We grew apart because we moved to different cities.",
        "He constantly tries to give me unsolicited life advice."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDE4F" // High five/pray
    ),
    TriviaQuestion(
      category: catLore,
      question: "Before moving and dealing with the school admission chaos, where was I originally born?",
      options: [
        "Madhuban",
        "Bhagalpur",
        "Patna",
        "Darbhanga"
      ],
      correctIndex: 0,
      emote: "\uD83C\uDFE1" // House
    ),
    
    // --- NERD ---
    TriviaQuestion(
      category: catNerd,
      question: "I am currently studying Civil Engineering at NIT. Why did I actually pick this branch?",
      options: [
        "I purely just wanted to get into an NIT, regardless of the branch.",
        "I thought it would leave me with enough free time to learn coding.",
        "My parents pressured me into taking a core engineering field.",
        "I actually wanted it initially, but realized later I hated it."
      ],
      correctIndex: 0,
      emote: "\uD83C\uDFD7\uFE0F" // Building
    ),
    TriviaQuestion(
      category: catNerd,
      question: "I’ve been trying to break into tech for two years. What is the biggest thing I’ve done so far to prove my hustle?",
      options: [
        "Leading the biggest tech club on campus (GDGC) and organizing HackMol.",
        "Landing a remote tech internship at a major startup.",
        "Winning the grand prize at a national-level hackathon.",
        "Building and selling a web-app to the college administration."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDCBB" // Laptop
    ),
    TriviaQuestion(
      category: catNerd,
      question: "I prefer DC over Marvel. What is my *exact* reasoning for this?",
      options: [
        "I find DC heroes more reasonable and grounded than Marvel's alien-fighting teams.",
        "I think DC's detective storylines appeal more to my love for Sherlock Holmes.",
        "DC's cinematic universe is darker and fits my taste in literature better.",
        "I actually grew up reading DC comics, whereas I only watched Marvel movies."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDDB8\u200D\u2642\uFE0F" // Superhero
    ),
    TriviaQuestion(
      category: catNerd,
      question: "When I finally started reading in 9th grade, how exactly did I kick off my reading journey?",
      options: [
        "I started with Detective Fiction and binge-read everything on Sherlock Holmes.",
        "I started with classic romantic literature before moving to mysteries.",
        "I started with non-fiction tech biographies before discovering Sherlock Holmes.",
        "I started with Hindi novels and then moved to Arthur Conan Doyle."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDD75\uFE0F\u200D\u2642\uFE0F" // Detective
    ),
    TriviaQuestion(
      category: catNerd,
      question: "What is the exact title of the latest Hindi novel I read?",
      options: [
        "Gunahon Ka Devta by Dharamveer Bharti",
        "Madhushala by Harivansh Rai Bachchan",
        "Godan by Munshi Premchand",
        "Raag Darbari by Shrilal Shukla"
      ],
      correctIndex: 0,
      emote: "\uD83D\uDCDA" // Books
    ),
    TriviaQuestion(
      category: catNerd,
      question: "What is my absolute favorite movie, and who is my favorite on-screen couple?",
      options: [
        "The Amazing Spider-Man; Peter & Gwen",
        "Spider-Man: No Way Home; Peter & MJ",
        "The Amazing Spider-Man; Peter & MJ",
        "The Dark Knight; Bruce & Rachel"
      ],
      correctIndex: 0,
      emote: "\uD83D\uDD77\uFE0F" // Spider
    ),
    TriviaQuestion(
      category: catNerd,
      question: "What is my absolute go-to genre to watch on Netflix when I just want to chill?",
      options: [
        "Something romantic",
        "A psychological thriller",
        "A true-crime detective documentary",
        "A Marvel or DC animated series"
      ],
      correctIndex: 0,
      emote: "\uD83D\uDE0D" // Heart eyes
    ),
    TriviaQuestion(
      category: catNerd,
      question: "What is the real reason I don't follow or play any major sports?",
      options: [
        "I'm just not that good at them and have been a nerd my whole life.",
        "I broke a bone playing cricket once and never went back.",
        "I find sports completely boring compared to books and movies.",
        "My parents never let me play outside because I had to study."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDD13" // Nerd
    ),
    TriviaQuestion(
      category: catNerd,
      question: "Which of these things is currently my biggest career frustration?",
      options: [
        "I haven't landed a big tech internship yet despite leading clubs and hackathons.",
        "I am failing my Civil Engineering core classes.",
        "Nobody uses the web apps and projects I build.",
        "I am completely burned out from organizing HackMol."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDD2C" // Cursing face
    ),
    TriviaQuestion(
      category: catNerd,
      question: "What is my most annoying (but endearing) habit when I am hyper-focused on coding?",
      options: [
        "I completely forget to text back or check my phone for hours.",
        "I talk to myself out loud and argue with the computer.",
        "I drink an unhealthy amount of coffee and forget to eat.",
        "I refuse to sleep until the bug is fixed."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDDD1\u200D\uD83D\uDCBB" // Coder
    ),

    // --- US (The Heart/Khadija) ---
    TriviaQuestion(
      category: catUs,
      question: "What fascinates me the absolute most about the world?",
      options: [
        "Understanding the behavior of people around me and asking deep questions.",
        "Figuring out how to manipulate narratives to build a massive tech network.",
        "Understanding the philosophical meanings hidden in classic literature.",
        "Learning how massive systems and algorithms dictate human choices."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDDE0" // Brain
    ),
    TriviaQuestion(
      category: catUs,
      question: "I call myself a 'Symbiote' when it comes to networking. What does that mean to me?",
      options: [
        "I thrive on making meaningful connections and feed off that energy.",
        "I attach myself to the smartest people in the room to learn tech faster.",
        "I drain the energy from parties because I'm actually an introvert.",
        "I blend into any social group seamlessly without showing my true self."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDD78\uFE0F" // Spiderweb/Symbiote
    ),
    TriviaQuestion(
      category: catUs,
      question: "My favorite quote is by the Greek philosopher Heraclitus. Which one is it?",
      options: [
        "No man ever steps in the same river twice, for it's not the same river and he's not the same man.",
        "There is nothing permanent except change.",
        "The only constant in life is change.",
        "We suffer more often in imagination than in reality."
      ],
      correctIndex: 0,
      emote: "\uD83C\uDF0A" // Wave
    ),
    TriviaQuestion(
      category: catUs,
      question: "I love doing big gestures (like coding this entire app). But what is my personal rule for gestures?",
      options: [
        "They must inspire and motivate me to build them, too.",
        "They must be a complete and total surprise.",
        "They must be public so people know how much I care.",
        "They must involve some kind of puzzle or game."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDE4C" // Praise/Build
    ),
    TriviaQuestion(
      category: catUs,
      question: "My relationship with my brother has changed a lot. What is my rule for partying now?",
      options: [
        "I really only like to party when my brother is around.",
        "I party every weekend now to make up for not having friends as a kid.",
        "I only party with my tech club friends, and keep my brother separate.",
        "I actually hate partying, I just go to network."
      ],
      correctIndex: 0,
      emote: "\uD83C\uDF89" // Party
    ),
    TriviaQuestion(
      category: catUs,
      question: "What was the defining feature of my childhood relationship with my mother?",
      options: [
        "Spending hours around her, just telling her tales.",
        "Reading my detective novels aloud to her.",
        "Watching wrestling with her while my brother was away.",
        "Having her help me write my creative stories."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDC69\u200D\uD83D\uDC66" // Mother son
    ),
    TriviaQuestion(
      category: catUs,
      question: "Out of all the reasons I love you, Khadija, what is the *defining* reason I always come back to?",
      options: [
        "Because you let me be exactly who I am, and accepted me for it.",
        "Because you are the only one who understands my deep philosophical questions.",
        "Because you motivate me to chase my tech career when I doubt myself.",
        "Because you match my extroverted 'symbiote' energy perfectly."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDC96" // Sparkle heart
    ),
    TriviaQuestion(
      category: catUs,
      question: "What was my *exact* first thought the very first time I saw you?",
      options: [
        "She is way out of my league.",
        "I need to go talk to her right now.",
        "She looks like she reads good books.",
        "I hope she doesn't notice me staring."
      ],
      correctIndex: 2,
      emote: "\uD83D\uDC40" // Eyes
    ),
    TriviaQuestion(
      category: catUs,
      question: "When we get into a stupid argument, who is usually the first one to break the silence?",
      options: [
        "Me (Adesh)",
        "You (Khadija)",
        "We both awkwardly start talking at the same time.",
        "We send each other a meme instead of actually apologizing."
      ],
      correctIndex: 2,
      emote: "\uD83D\uDE48" // See no evil monkey
    ),
    TriviaQuestion(
      category: catUs,
      question: "If I had to delete all the apps on my phone except for three, I would keep WhatsApp, Spotify, and...",
      options: [
        "GitHub (The hustle never stops)",
        "Netflix (For the rom-coms)",
        "VS Code / Antigravity (To fix this app)",
        "My gallery (To look at our photos)"
      ],
      correctIndex: 3,
      emote: "\uD83D\uDCF1" // Phone
    ),
    TriviaQuestion(
      category: catUs,
      question: "Under what specific condition do I actually enjoy going out and partying?",
      options: [
        "Only when my brother is around to party with me.",
        "Only if it's a tech meetup or a hackathon afterparty.",
        "Only if you (Khadija) force me to go out.",
        "Only if there is free food and I don't have to talk to anyone."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDD43" // Drinks
    ),
    TriviaQuestion(
      category: catUs,
      question: "What is my absolute favorite way to spend a lazy Sunday with you?",
      options: [
        "Binge-watching a cheesy Netflix rom-com in our pajamas.",
        "Going out for a long drive and finding a new cafe.",
        "Sitting in comfortable silence while I code and you do your own thing.",
        "Taking you out shopping or doing activities all day."
      ],
      correctIndex: 0,
      emote: "\uD83D\uDECF\uFE0F" // Bed
    ),
    TriviaQuestion(
      category: catUs,
      question: "If I am having a terrible, stressful day, what is the single fastest way to fix my mood?",
      options: [
        "You giving me a hug and letting me vent.",
        "Sending me a funny meme or an inside joke.",
        "Leaving me completely alone in a dark room for an hour.",
        "Buying me my favorite food."
      ],
      correctIndex: 3,
      emote: "\uD83C\uDF55" // Pizza
    ),
    TriviaQuestion(
      category: catUs,
      question: "If I had to describe you (Khadija) to a stranger in one word, what would I use?",
      options: [
        "My anchor.",
        "My peace.",
        "My muse.",
        "My partner-in-crime."
      ],
      correctIndex: 1,
      emote: "\uD83D\uDD4A\uFE0F" // Dove/Peace
    ),
    TriviaQuestion(
      category: catUs,
      question: "What is the one thing you do that instantly makes me melt?",
      options: [
        "The way you smile when you're genuinely laughing at my jokes.",
        "When you randomly text me to tell me you're proud of me.",
        "How you remember the tiny details about my day that I mentioned weeks ago.",
        "When you defend me or take my side in an argument."
      ],
      correctIndex: 0,
      emote: "\uD83E\uDD7A" // Pleading/Melting face
    ),
  ];

  static List<TriviaQuestion> getQuestionsForCategory(String category) {
    var qs = allQuestions.where((q) => q.category == category).toList();
    // Shuffle the questions first
    qs.shuffle();
    
    // We only want 5 questions per round, but we need to shuffle the options for EACH of those 5 questions
    // AND we must track the correct answer!
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
