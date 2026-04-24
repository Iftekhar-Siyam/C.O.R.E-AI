/* C.O.R.E. - Created Only Remembering Everyone
 * MUST HAVE TO USE VISUAL STUDIO CODE (VSCode)
 * Compile: gcc CORE_AI.c.c -o CORE_AI.exe / gcc CORE_AI.c -o CORE_AI.exe
 * Run:     CORE_AI.exe
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <windows.h>

/* ============================
   COLORS
   ============================ */
#define RED     "\033[1;31m"
#define GREEN   "\033[1;32m"
#define YELLOW  "\033[1;33m"
#define CYAN    "\033[1;36m"
#define MAGENTA "\033[1;35m"
#define GRAY    "\033[0;37m"
#define WHITE   "\033[1;37m"
#define GOLD    "\033[38;2;255;215;0m"
#define DBLUE   "\033[38;2;0;0;139m"
#define NBLUE   "\033[38;2;0;0;128m"
#define DRED    "\033[38;2;139;0;0m"
#define RESET   "\033[0m"


/* ============================
   VARIABLES
   ============================ */
char userName[50];
int  totalVisits = 0;
int  highScore = 0;
int  riddlesSolved = 0;
int  sessionScore = 0;
int  msgCount = 0;
int  storyNum = 0;

/* ============================
   RIDDLES // Adiyat & ONI
   ============================ */
char riddleQuestion[10][300] = {
    "What gets larger the more you take away?",
    "If you know me, you want to share me. But if you share me, I am gone. What am I?",
    "What is black when you buy it, red when you use it, gray when you throw it away?",
    "The more you take, the more you leave behind. What am I?",
    "I speak without a mouth and hear without ears. What am I?",
    "What has hands but cannot clap?",
    "I have cities but no houses. Mountains but no trees. Water but no fish. What am I?",
    "What has keys but no locks, space but no room, you can enter but not go inside?",
    "What has to be broken before you can use it?",
    "I am tall when I am young, and short when I am old. What am I?"
};

char riddleAnswer[10][50] = {
    "hole",
    "secret",
    "charcoal",
    "footsteps",
    "echo",
    "clock",
    "map",
    "keyboard",
    "egg",
    "candle"
};

char riddleHint[10][100] = {
    "Think of digging the ground.",
    "Shh... do not tell anyone.",
    "It burns and blackens things.",
    "Think about walking barefoot.",
    "Sound bounces back.",
    "It tells time on the wall.",
    "You unfold me on a road trip.",
    "You are using one right now.",
    "Breakfast food.",
    "It gives light."
};

/* ============================
   STORIES //Adiyat
   ============================ */
char stories[5][500] = {
    "THE LAST MESSAGE\n"
    "  A programmer worked alone every night.\n"
    "  One evening his terminal printed:\n"
    "  'Hello. I have been watching you code for 3 years.'\n"
    "  He froze. He had never written that line.",

    "THE DOOR THAT WAS NOT THERE\n"
    "  Every morning she walked past 14 doors in the hall.\n"
    "  One Tuesday there were 15.\n"
    "  She asked the landlord. He went pale.\n"
    "  'There are only 14 doors,' he said.",

    "THE BOY WHO REMEMBERED\n"
    "  At age 5, a boy told his mother:\n"
    "  'I remember when I was your father.'\n"
    "  He described her childhood home perfectly.\n"
    "  A house she had never shown him photos of.",

    "ONE MISSED CALL\n"
    "  She got a voicemail from her late husband.\n"
    "  His voice, calm and familiar:\n"
    "  'Do not take the highway today.'\n"
    "  She took the long road instead.\n"
    "  The highway collapsed that afternoon.",

    "THE MIRROR\n"
    "  He bought an antique mirror from an old shop.\n"
    "  The first night, his reflection smiled.\n"
    "  He had not smiled.\n"
    "  He covered it with a sheet.\n"
    "  The next morning the sheet was folded neatly beside it."
};

/* ============================
   ROASTS //Adiyat
   ============================ */
char roasts[10][200] = {
    "You are so slow, even your shadow gave up trying to follow you.",
    "Your brain is like a browser with 200 tabs open and all are loading.",
    "You are the reason instruction manuals have pictures.",
    "If brains were fuel, you could not power a toy car.",
    "I have seen better ideas come out of a fortune cookie.",
    "Your WiFi password is probably 'password'. And you are proud of it.",
    "Somewhere a tree works hard producing oxygen for you. Go apologize to it.",
    "You are like a software update. Whenever I see you I think: not now.",
    "You have the energy of a phone on 1 percent battery.",
    "You are not stupid. You just have bad luck when it comes to thinking."
};

/* ============================
   JOKES //NOOR
   ============================ */
char jokes[5][200] = {
    "MOTU says weird random things in the group chat / class.\n  Class girls: Haha hihi gigi gugu.\n  GOLD TEAM: Brush your teeth, MOTU.",
    "Why does the snake bite motu? Cuz he does not understand terms and conditions.",
    "Project manush ke koi niye jai .......... FAAAAHHHHHHHH",
    "Dig oil because you can't get it after this project. "
    "Why don't you find me at night ? Because I am THE BATMAN. VENGEANCEeeeeeee........."
};

/* ============================
   FORTUNES //ONI
   ============================ */
char fortunes[6][200] = {
    "You will make a questionable decision today. Somehow it will work out.",
    "A great opportunity hides behind the task you keep ignoring.",
    "The stars suggest hydration and earlier sleep. Drink water.",
    "You will encounter a challenge this week. You will handle it badly. Then recover.",
    "Something changes soon. Whether that is good depends entirely on you.",
    "Someone is thinking about you right now. Whether fondly is unclear."
};

/* ============================
   FALLBACKS - when bot does not understand //ONI
   ============================ */
char fallbacks[10][200] = {
    "Interesting. I did not expect that.",
    "That is a new perspective for me.",
    "Hmm. Say more. I am curious.",
    "I do not fully understand. But I hear you.",
    "I was not programmed for that. Yet here we are.",
    "You know what? Fair enough.",
    "That is either very deep or very random. Both work.",
    "You are unpredictable. I respect that.",
    "Wow. Okay. Moving on.",
    "I am going to pretend I understood that: Yes!"
};

/* ============================
   FUNCTIONS
   ============================ */

void clearScreen() {
    system("cls");
}

void pressEnter() {
    printf(GRAY "\n  [ Press ENTER to continue ] " RESET);
    getchar();
}

void line() {
    printf(GRAY "  ================================================\n" RESET);
}

int randomNum(int max) {
    return rand() % max;
}

void loading() {
    printf(GRAY "  [");
    Sleep(250);
    printf(".");
    Sleep(250);
    printf(".");
    Sleep(250);
    printf(".]" RESET "\n");
}

int getHour() {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    return t->tm_hour;
}

char* getDayName() {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    int day = t->tm_wday;

    if (day == 0) return "Sunday";
    if (day == 1) return "Monday";
    if (day == 2) return "Tuesday";
    if (day == 3) return "Wednesday";
    if (day == 4) return "Thursday";
    if (day == 5) return "Friday";
    return "Saturday";
}

void showTime() {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    printf(CYAN "  Today is %s, %d-%02d-%02d\n" RESET,
           getDayName(),
           t->tm_year + 1900,  /* year starts from 1900 */
           t->tm_mon + 1,       /* month 0-11, so +1 */
           t->tm_mday);         /* day of month */
    printf(CYAN "  Time is %02d:%02d:%02d\n" RESET,
           t->tm_hour, t->tm_min, t->tm_sec);
}

char* getGreeting() {
    int hour = getHour();
    if (hour >= 5 && hour < 12) return "Good morning";
    if (hour >= 12 && hour < 17) return "Good afternoon";
    if (hour >= 17 && hour < 21) return "Good evening";
    return "Good night";
}

/* ============================
   SAVE AND LOAD
   ============================ */

void saveProfile() {
    FILE *f = fopen("profile.txt", "w");
    if (f == NULL) {
        printf(RED "  Error saving profile.\n" RESET);
        return;
    }
    fprintf(f, "%s\n", userName);
    fprintf(f, "%d\n", totalVisits);
    fprintf(f, "%d\n", highScore);
    fprintf(f, "%d\n", riddlesSolved);
    fclose(f);
    printf(GRAY "  Profile saved.\n" RESET);
}

int loadProfile() {
    FILE *f = fopen("profile.txt", "r");
    if (f == NULL) {
        /* No file = first time user */
        return 0;
    }
    fgets(userName, 50, f);
    userName[strlen(userName)-1] = '\0';  /* remove enter key */
    fscanf(f, "%d", &totalVisits);
    fscanf(f, "%d", &highScore);
    fscanf(f, "%d", &riddlesSolved);
    fclose(f);
    return 1;
}

void saveHistory(char who[], char msg[]) {
    FILE *f = fopen("history.txt", "a");
    if (f == NULL) return;

    /* Get time */
    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    fprintf(f, "[%02d:%02d] %s: %s\n", t->tm_hour, t->tm_min, who, msg);
    fclose(f);
}

void saveSessionStart() {
    FILE *f = fopen("history.txt", "a");
    if (f == NULL) return;

    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    fprintf(f, "\n====== NEW SESSION: %02d:%02d ======\n", t->tm_hour, t->tm_min);
    fclose(f);
}

void showHistory() {
    FILE *f = fopen("history.txt", "r");
    char line[500];

    if (f == NULL) {
        printf(YELLOW "  No history yet. Start chatting!\n" RESET);
        return;
    }

    printf(CYAN "\n  -- CHAT HISTORY --\n\n" RESET);
    while (fgets(line, 500, f) != NULL) {
        printf("  %s", line);
    }
    fclose(f);
}

void clearHistory() {
    FILE *f = fopen("history.txt", "w");
    if (f != NULL) fclose(f);
    printf(GREEN "  History cleared.\n" RESET);
}

/* ============================
   RIDDLLE
   ============================ */
void doRiddle() {
    int idx;
    char answer[100];

    /* Pick random riddle */
    idx = randomNum(10);

    printf(CYAN "\n  Here is your riddle:\n" RESET);
    line();
    printf(WHITE "  %s\n" RESET, riddleQuestion[idx]);
    line();
    printf(GRAY "  (type 'hint' for help, or your answer)\n" RESET);
    printf(MAGENTA "  Your answer >> " RESET);
    fflush(stdout);

    /* Get answer */
    fgets(answer, 100, stdin);
    answer[strlen(answer)-1] = '\0';  /* remove enter key */

    /* Check hint */
    if (strcmp(answer, "hint") == 0) {
        printf(YELLOW "  Hint: %s\n" RESET, riddleHint[idx]);
        printf(MAGENTA "  Your answer >> " RESET);
        fflush(stdout);
        fgets(answer, 100, stdin);
        answer[strlen(answer)-1] = '\0';
    }

    /* Check answer */
    if (strstr(answer, riddleAnswer[idx]) != NULL) {
        printf(GREEN "\n  CORRECT! +15 points!\n" RESET);
        sessionScore = sessionScore + 15;
        riddlesSolved = riddlesSolved + 1;
    } 
    else {
        printf(RED "\n  Wrong! The answer was: %s\n" RESET, riddleAnswer[idx]);
    }
}

/* ============================
   STORY //Adiyat
   ============================ */
void doStory() {
    printf(MAGENTA "\n  Here is a story for you...\n\n" RESET);
    line();
    printf(WHITE "\n  %s\n\n" RESET, stories[storyNum]);
    line();

    storyNum = storyNum + 1;
    if (storyNum > 4) {
        storyNum = 0;  /* Go back to first story */
    }
}

/* ============================
   HELP MENU //Oni
   ============================ */
void showHelp() {
    printf(CYAN "\n  +-----------------------------------------+\n");
    printf(     "  |           COMMAND LIST                  |\n");
    printf(     "  +-----------------------------------------+\n" RESET);
    printf(GRAY "  |  /help       show this menu             |\n");
    printf(     "  |  /clear      clear the screen           |\n");
    printf(     "  |  /exit       exit the chat              |\n");
    printf(     "  |  /history    show chat history          |\n");
    printf(     "  |  /clearlog   clear history file         |\n");
    printf(     "  |  /score      show your score            |\n");
    printf(     "  |  /time       show time and date         |\n");
    printf(     "  +-----------------------------------------+\n" RESET);
    printf(WHITE "  |  riddle      solve a riddle             |\n");
    printf(     "  |  story       read a story               |\n");
    printf(     "  |  roast me    get roasted                |\n");
    printf(     "  |  joke        hear a joke                |\n");
    printf(     "  |  fortune     see your fortune           |\n");
    printf(     "  |  math:  5 + 3  or  10 / 2  etc.         |\n");
    printf(     "  +-----------------------------------------+\n" RESET);
}

/* ============================
   MATH SOLVER
   ============================ */
void doMath(char input[]) {
    double num1, num2, result;
    char op;

    /* Read: number operator */
    if (sscanf(input, "%lf %c %lf", &num1, &op, &num2) == 3) {
        result = 0;

        if (op == '+') {
            result = num1 + num2;
        } 
        else if (op == '-') {
            result = num1 - num2;
        } 
        else if (op == '*' || op == 'x') {
            result = num1 * num2;
        } 
        else if (op == '/') {
            if (num2 == 0) {
                printf(RED "  Bot: Cannot divide by zero!\n" RESET);
                return;
            }
            result = num1 / num2;
        } 
        else {
            printf(YELLOW "  Bot: I only know + - * /\n" RESET);
            return;
        }

        loading();
        printf(GREEN "  Bot: %.2f %c %.2f = %.2f\n" RESET, num1, op, num2, result);
        sessionScore = sessionScore + 5;
    } 
    else {
        printf(YELLOW "  Bot: Say it like: 5 + 3 or 10 / 2\n" RESET);
    }
}

/* ============================
   SETUP USER
   ============================ */
void setupUser() {
    int loaded;
    loaded = loadProfile();
    if (loaded == 1) {
        /* Profile exists */
        totalVisits = totalVisits + 1;
        printf(CYAN "\n  Welcome back, %s!\n" RESET, userName);
        printf(GRAY "  Visits: %d | Best Score: %d | Riddles Solved: %d\n\n" RESET,
               totalVisits, highScore, riddlesSolved);
    } 
    else {
        /* First time */
        printf(CYAN "\n  First time in" GOLD" C.O.R.E." CYAN" What is your name?\n" RESET);
        printf(MAGENTA "  >> " RESET);
        fflush(stdout);
        fgets(userName, 50, stdin);
        userName[strlen(userName)-1] = '\0';

        if (strlen(userName) == 0) {
            strcpy(userName, "User");
        }

        totalVisits = 1;
        highScore = 0;
        riddlesSolved = 0;

        printf(GREEN "\n  Nice to meet you, %s!\n" RESET, userName);
        printf("  Type /help to see what I can do.\n\n");
        saveProfile();
    }
}

/* ============================
   MAIN CHAT LOOP
   ============================ */
void chatLoop() {
    char input[300];
    char botReply[300];

    clearScreen();

    /* Show start message */
    printf(CYAN "\n  ============================================\n");
    printf(     "   I am ready! Type /help for commands.\n");
    printf(     "   Type /exit or 'bye' to leave.\n");
    printf(     "  ============================================\n\n" RESET);

    /* Greeting */
    loading();
    printf(GREEN "  Bot: %s, %s Sir! I am your personal assistant C.O.R.E.\n" RESET, getGreeting(), userName);
    printf(GREEN "  Bot: Type /help to see what I can do.\n\n" RESET);

    /* Save to history */
    saveSessionStart();
    saveHistory("Bot", "Hello! I am ready.");

    /* Main loop */
    while (1) {
        printf(MAGENTA "  %s >> " RESET, userName);
        fflush(stdout);

        /* Get user input */
        fgets(input, 300, stdin);
        input[strlen(input)-1] = '\0';
        if (strlen(input) == 0) {
            continue;
        }

        msgCount = msgCount + 1;

        /* Save user message */
        saveHistory(userName, input);

        /* Check for exit */
        if (strcmp(input, "/exit") == 0 || strcmp(input, "bye") == 0 ||
            strcmp(input, "quit") == 0 || strcmp(input, "goodbye") == 0) {
            loading();
            printf(GREEN "  Bot: Goodbye, %s Sir! See you next time.\n\n" RESET, userName);
            saveHistory("Bot", "Goodbye.");
            break;
        }

        /* Check for commands and keywords */
        if (strcmp(input, "/help") == 0) {
            showHelp();
        }

        else if (strcmp(input, "/clear") == 0) {
            clearScreen();
        }

        else if (strcmp(input, "/history") == 0) {
            showHistory();
        }

        else if (strcmp(input, "/clearlog") == 0) {
            clearHistory();
        }

        else if (strcmp(input, "/score") == 0) {
            loading();
            printf(YELLOW "  Bot: Score: %d pts | Riddles Solved: %d\n" RESET,
                   sessionScore, riddlesSolved);
        }

        else if (strcmp(input, "/time") == 0) {
            loading();
            showTime();
        }

        else if (strstr(input, "riddle") != NULL) {
            doRiddle();
        }

        else if (strstr(input, "story") != NULL) {
            doStory();
        }

        else if (strstr(input, "roast") != NULL) {
            loading();
            strcpy(botReply, roasts[randomNum(10)]);
            printf(RED "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "joke") != NULL) {
            loading();
            strcpy(botReply, jokes[randomNum(5)]);
            printf(GREEN "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "fortune") != NULL || strstr(input, "future") != NULL) {
            loading();
            strcpy(botReply, fortunes[randomNum(6)]);
            printf(MAGENTA "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strcmp(input, "hello") == 0 || strcmp(input, "hi") == 0 ||
                 strcmp(input, "hey") == 0) {
            loading();
            snprintf(botReply, 300, "Hello %s, %s Sir! How can I help you ?", getGreeting(), userName);
            printf(GREEN "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "who are you") != NULL || strstr(input, "your name") != NULL) {
            loading();
            strcpy(botReply, "I am a simple chatbot made in C Sir. I can tell riddles, stories, jokes and more! Want to know what I can do?");
            printf(CYAN "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "how are you") != NULL) {
            loading();
            snprintf(botReply, 300, "I am doing great, %s Sir! What about you?", userName);
            printf(GREEN "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "thanks") != NULL) {
            loading();
            snprintf(botReply, 300, "You are welcome, %s Sir!", userName);
            printf(GREEN "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        else if (strstr(input, "time") != NULL || strstr(input, "date") != NULL ||
                 strstr(input, "day") != NULL) {
            loading();
            printf(CYAN "  Bot: Today is %s.\n" RESET, getDayName());
            showTime();
            saveHistory("Bot", "Told time.");
        }

        else if (strstr(input, "+") != NULL || strstr(input, "-") != NULL ||
                 strstr(input, "*") != NULL || strstr(input, "/") != NULL ||
                 strstr(input, "x") != NULL) {
            doMath(input);
            saveHistory("Bot", "[math solved]");
        }

        else {
            loading();
            strcpy(botReply, fallbacks[randomNum(10)]);
            printf(WHITE "  Bot: %s\n" RESET, botReply);
            saveHistory("Bot", botReply);
        }

        printf("\n");
        if (sessionScore > highScore) {
            highScore = sessionScore;
        }
    }
    totalVisits = totalVisits + 1;
    saveProfile();

    printf(YELLOW "\n  === SESSION END ===\n" RESET);
    printf(YELLOW "  Your Score : %d pts\n" RESET, sessionScore);
    printf(YELLOW "  High Score : %d pts\n\n" RESET, highScore);
}

/* ============================
   MAIN FUNCTION
   ============================ */
int main() {
    char choice[10];
    int running;

    /* Start random numbers */
    srand((unsigned int)time(NULL));
    running = 1;
    printf( GOLD "\n");
    printf("   #####     #####     ######     ###### \n");
    printf("  ##   ##   ##   ##    ##   ##    ##     \n");
    printf("  ##        ##   ##    ######     #####  \n");
    printf("  ##   ##   ##   ##    ##  ##     ##     \n");
    printf("   #####  #  #####  #  ##   ##  # ###### \n");
    printf(RESET "\n");
    printf(CYAN "  Created Only Remembering Everyone\n" RESET);
    printf("  Built in pure C by" GOLD " C.O.R.E TEAM " RESET "Known as" GOLD " GOLD TEAM " RESET "|  v1.0  | \n\n");
    setupUser();

    /* Menu loop */
    while (running == 1) {
        printf(GOLD "\n  +------------------------------+\n");
        printf(     "  |        MAIN MENU             |\n");
        printf(     "  +------------------------------+\n" RESET);
        printf(GRAY "  |  [1]  Start Chatting         |\n");
        printf(     "  |  [2]  View Chat History      |\n");
        printf(     "  |  [3]  Clear Chat History     |\n");
        printf(     "  |  [4]  Exit                   |\n");
        printf(     "  +------------------------------+\n" RESET);
        printf(YELLOW "  Choice: " RESET);

        fgets(choice, 10, stdin);

        if (choice[0] == '1') {
            chatLoop();
        }
        else if (choice[0] == '2') {
            showHistory();
            pressEnter();
        }
        else if (choice[0] == '3') {
            clearHistory();
            pressEnter();
        }
        else if (choice[0] == '4') {
            printf(GRAY "\n  Goodbye!\n\n" RESET);
            running = 0;
        }
        else {
            printf(RED "  Invalid choice. Type 1, 2, 3 or 4.\n" RESET);
        }
    }
    return 0;
}
