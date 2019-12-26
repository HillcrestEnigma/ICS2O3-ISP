StringDict state = new StringDict();
PImage mazeImg;
PFont font;
StringList curVimDisplay;
String[] helpMessage;

void store(String dict_key, int value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, float value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, String value) {
    state.set(dict_key, value);
}

String fetch(String dict_key) {
   return state.get(dict_key);
}

int fetchInt(String dict_key) {
    return Integer.parseInt(fetch(dict_key));
}

float fetchFloat(String dict_key) {
    return Float.parseFloat(fetch(dict_key));
}

boolean fetchBool(String dict_key) {
    return boolean(fetch(dict_key));
}

void callFunc() {
    store("curTime", millis());
    if (fetch("setState").equals("none")) {
        if (fetchInt("curTime") <= 5000) {
            store("newState", "loading");
        } else if ((!fetchBool("skipAnimation")) && (fetchInt("curTime") < 35000 && fetchInt("curTime") > 5000)) {
            store("newState", "animation");
        } else if (fetch("lastState").equals("mainMenu") || fetch("lastState").equals("animation")) {
            store("newState", "mainMenu");
        } else if (fetch("lastState").equals("help")) {
            store("newState", "help");
        } else if (fetch("lastState").equals("maze")) {
            store("newState", "maze");
        } else if (fetch("lastState").equals("game")) {
            store("newState", "game");
        } else if (fetch("lastState").equals("exit")) {
            store("newState", "exit");
        }
    } else {
        store("newState", fetch("setState"));
        store("setState", "none");
    }

    if (!fetch("newState").equals(fetch("lastState"))) {
        store("stateStartTime", millis());
        store("lastState", fetch("newState"));
        println(fetch("newState"));
    }
    store("stateCurTime", millis()-fetchInt("stateStartTime"));
    if (fetch("newState").equals("loading")) {
        loading();
    } else if (fetch("newState").equals("animation")) {
        animation();
    } else if (fetch("newState").equals("mainMenu")) {
        mainMenu();
    } else if (fetch("newState").equals("help")) {
        help();
    } else if (fetch("newState").equals("maze")) {
        maze();
    } else if (fetch("newState").equals("game")) {
        game();
    } else if (fetch("newState").equals("exit")) {
        goodbye();
    }
    store("newState", "none");
}

void animation() {
    rectMode(CORNERS); 
    store("state", "animation");
    store("aniTime", fetchInt("curTime") - 5000);
    if (fetchInt("aniTime") < 10000) {
        store("aniScene", "typing");
    } else if (fetchInt("aniTime") < 15000) {
        store("aniScene", "submitting");
    } else if (fetchInt("aniTime") < 20000) {
        store("aniScene", "frowning");
    } else if (fetchInt("aniTime") < 25000) {
        store("aniScene", "learning");
    } else {
        store("aniScene", "fadeout");
    }

    if (fetch("aniScene").equals("typing") || fetch("aniScene").equals("submitting") || fetch("aniScene").equals("learning") || fetch("aniScene").equals("fadeout")) {
        fill(100);
        rect(50, 50, width-50, 400);
        fill(200);
        rect(75, 75, width-75, 375);
        fill(100);
        rect(width/2-50, 400, width/2+50, 425);
        rect(width/2-100, 425, width/2+100, 450);
        fill(150);
        rect(75, 500, width-75, 825);
        fill(175);
        for (int i=100; i<=width-150; i+=75) {
            for (int j=525; j<=height-150; j+=75) {
                rect(i, j, i+50, j+50);
            }
        }
        if (fetch("aniScene").equals("typing")) {
            store("aniHandTime", fetchInt("aniTime") % 2000);
            store("aniHandHeightDelta", abs(fetchInt("aniHandTime") - 1000)/10);
            rect(width/2-100, 600 + fetchFloat("aniHandHeightDelta"), width/2-50, height);
            rect(width/2+50, 700 - fetchFloat("aniHandHeightDelta"), width/2+100, height);
        } else if (fetch("aniScene").equals("submitting")) {
            fill(255, 100, 100);
            textSize(25);
            text("Typing Speed: 10 Words Per Min", 100, 100, width-100, 350);
        } else if (fetch("aniScene").equals("learning") || fetch("aniScene").equals("fadeout")) {
            fill(100, 100, 255);
            textSize(25);
            text("Want to learn to type faster? Learn Vim!", 100, 100, width-100, 350);
        }
        if (fetch("aniScene").equals("fadeout")) {
          fill(0, (fetchInt("aniTime")-25000)/19.6);
          rect(0, 0, width, height);
        }
    } else if (fetch("aniScene").equals("frowning")) {
        ellipseMode(CENTER);
        fill(100, 100, 255);
        store("aniMouthPointsDelta", (fetchInt("aniTime")-15000)/100);
        rect(width/2-300, 150, width/2+300, height, 30, 30, 0, 0); 
        rect(width/2-325, 150, width/2-275, height/2, 30, 30, 30, 30);
        rect(width/2+325, 150, width/2+275, height/2, 30, 30, 30, 30);
        fill(255);
        circle(width/2, 150, 150);
        fill(155);
        circle(width/2-25, 125, 10);
        circle(width/2+25, 125, 10);
        bezier(width/2-40, 160+fetchFloat("aniMouthPointsDelta"), width/2-40, 210-fetchFloat("aniMouthPointsDelta"), width/2+40, 210-fetchFloat("aniMouthPointsDelta"), width/2+40, 160+fetchFloat("aniMouthPointsDelta"));
    }

}

void loading() {
    store("state", "loading");
    store("loadTime", fetchInt("curTime"));
    store("loadPercent", fetchInt("loadTime")/50);
    store("loadRectY", lerp(0, height, (100-fetchFloat("loadPercent"))/100));

    fill(255, 100, 100);
    rect(0, fetchFloat("loadRectY"), width, height);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    noStroke();
    text(fetch("loadPercent") + "%", width/2, height/2);

}

void mainMenu() {
    fill(0);
    stroke(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Ley learns Vim!", width/2, 100);

    rectMode(CENTER);
    fill(155);
    textSize(20);
    rect(width/2, 400, 200, 100);
    rect(width/2, 525, 200, 100);
    rect(width/2, 650, 200, 100);
    rect(width/2, 775, 200, 100);

    fill(255);
    text("Instructions", width/2, 400);
    text("Start Maze", width/2, 525);
    text("Start Game", width/2, 650);
    text("Exit Game", width/2, 775);

    fill(155, 155, 100, 75);
    noStroke();
    store("mainMenuHoveringButton", "none");
    if (mouseX >= width/2-100 && mouseX <= width/2+100) {
        if (mouseY >= 350 && mouseY <= 450) {
            rect(width/2, 400, 180, 80);
            store("mainMenuHoveringButton", "instruction");
        } else if (mouseY >= 475 && mouseY <= 575) {
            rect(width/2, 525, 180, 80);
            store("mainMenuHoveringButton", "startMaze");
        } else if (mouseY >= 600 && mouseY <= 700) {
            rect(width/2, 650, 180, 80);
            store("mainMenuHoveringButton", "startGame");
        } else if (mouseY >= 725 && mouseY <= 825) {
            rect(width/2, 775, 180, 80);
            store("mainMenuHoveringButton", "exit");
        }
    }

    if (mousePressed) {
        if (fetch("mainMenuHoveringButton").equals("instruction")) {
            store("setState", "help");
        } else if (fetch("mainMenuHoveringButton").equals("startMaze")) {
            store("setState", "maze");
        } else if (fetch("mainMenuHoveringButton").equals("startGame")) {
            store("setState", "game");
        } else if (fetch("mainMenuHoveringButton").equals("exit")) {
            store("setState", "exit");
        }
    }
}

void station1() {

}

void station2() {

}

void station3() {

}

void station4() {

}

void station5() {

}

void help() {
    store("state", "instructions");
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("helpMessage"), 50, 50, width-50, height-50);

    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "mainMenu");
        store("keystrokes", fetch("keystrokes") + "none");
    }
}

void goodbye() {
    store("state", "exit");
    if (fetchInt("stateCurTime") < 5000) {
        textSize(30);
        textAlign(CENTER, CENTER);
        fill(0);
        text("Thank you for playing this glorious game!", width/2, 400);
        textSize(20);
        text("The game will exit in 5 seconds...", width/2, 600);
    } else {
        exit();
    }
}

void maze() {
    store("state", "maze");
}

void game() {
    store("state", "game");
}

void mouseReleased() {
    if (fetch("state").equals("animation")) {
        store("skipAnimation", "true");
        store("setState", "mainMenu");
    }
}

void keyPressed() {
    store("keystrokes", fetch("keystrokes") + key);
    if (key == ESC) {
        store("curVimCommand", "");
    } else {
        store("curVimCommand", fetch("curVimCommand") + key);
    }

    key = 0; // https://processing.org/discourse/beta/num_1276201899.html
}

void draw() {
    background(255);
    stroke(0);

    callFunc();

    fill(0);
    textSize(15);
    textAlign(LEFT, TOP);
    text("("+mouseX+", "+mouseY+")", mouseX, mouseY);

    store("keystrokesLen", fetch("keystrokes").length());

    // rectMode(CORNERS);
    // fill(255);
    // rect(0, height-25, width, height);
    // fill(50);
    // noStroke();
    // textSize(10);
    // text(fetch("curVimCommand"), width*6/10, height);
    
    // store("curVimCommandLen", fetch("curVimCommand").length());
    // if (fetchInt("curVimCommandLen") > 1) {
    //     store("curVimCommand", "");
    // } else if (fetch("curVimCommand").endsWith("\n")) {
    //     store("curVimCommand", "");
    // }
}

void setup() {
    size(900, 900);
    frameRate(30);
    font = createFont("font.ttf", 20);
    textFont(font);
    store("initTime", millis());   
    store("aniScene", "none");
    store("stateTime", "none");
    store("lastState", "none");
    store("skipAnimation", "false");
    store("setState", "none");
    store("keystrokes", "none");
    store("curVimCommand", "");

    helpMessage = loadStrings("help.txt");
    store("helpMessage", join(helpMessage, "\n"));
}
