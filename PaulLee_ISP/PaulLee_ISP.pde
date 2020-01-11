// Paul Lee 9Q WLMCI
// ICS2O3
// Ms.Krasteva
// ICS ISP - Ley learns VIM!

// Citations
// Passing parameters into functions: https://processing.org/examples/functions.html
// StringDict: https://processing.org/reference/StringDict.html
// Array: https://processing.org/reference/Array.html
// Declearing 2D arrays in Processing: MCPT Game Dev Team (Derek Zhang, Ben Zeng, Dereck Tu, Marina Semenova)
// Integer.parseInt(): https://www.tutorialspoint.com/java/number_parseint.htm
// Float.parseFloat(): https://www.geeksforgeeks.org/float-parsefloat-method-in-java-with-examples/
// boolean(): https://processing.org/reference/booleanconvert_.html
// concat(): https://processing.org/reference/concat_.html
// subset(): https://processing.org/reference/subset_.html
// new ...: https://processing.org/reference/new.html
// millis(): https://processing.org/reference/millis_.html
// max(): https://processing.org/reference/max_.html
// random(): https://processing.org/reference/random_.html
// int(): https://processing.org/reference/intconvert_.html
// join(): https://processing.org/reference/join_.html
// split(): https://processing.org/reference/split_.html
// Typography: https://processing.org/tutorials/typography/
// get(): https://processing.org/reference/get_.html
// Str.endsWith(): https://www.tutorialspoint.com/java/java_string_endswith.htm
// Character.isLetterOrDigit(): https://www.tutorialspoint.com/java/lang/character_isletterordigit.htm
// Str.length(): https://www.tutorialspoint.com/java/java_string_length.htm
// min(): https://processing.org/reference/min_.html
// keyPressed(): https://processing.org/reference/keyPressed_.html (Thanks for Adam and Neik for recommending keyPressed)
// key: https://processing.org/reference/key.html
// keyCode: https://processing.org/reference/keyCode.html
// Prevent Processing from exiting when the escape key is pressed: https://processing.org/discourse/beta/num_1276201899.html
// loadStrings(): https://processing.org/reference/loadStrings_.html
// loadImage(): https://processing.org/reference/loadImage_.html

StringDict state = new StringDict();
PImage mazeImg;
PFont font;
char[][] curVimDisplay = new char[25][25];
int[][] gameToDelete = new int[25][2];

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

char[] deleteSubset(char[] array, int startIndex, int endIndex) {
    return concat(concat(subset(array, 0, startIndex), subset(array, endIndex + 1)), new char[endIndex - startIndex + 1]);
}

// void deepCopy(char[][] source_array, char[][] dest_array) {
//     for (int i=0; i<source_array.length; i++) {
//         arrayCopy(source_array[i], dest_array[i]);
//     }
// }

// char[][] deleteSubset(char[][] array, int startIndex, int endIndex) {
//     return concat(subset(array, 0, startIndex), subset(array, endIndex + 1));
// }

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
        } else if (fetch("lastState").equals("station1")) {
            store("newState", "station1");
        } else if (fetch("lastState").equals("station2")) {
            store("newState", "station2");
        } else if (fetch("lastState").equals("station3")) {
            store("newState", "station3");
        } else if (fetch("lastState").equals("station4")) {
            store("newState", "station4");
        } else if (fetch("lastState").equals("station5")) {
            store("newState", "station5");
        } else if (fetch("lastState").equals("station6")) {
            store("newState", "station6");
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
    } else if (fetch("newState").equals("station1")) {
        station1();
    } else if (fetch("newState").equals("station2")) {
        station2();
    } else if (fetch("newState").equals("station3")) {
        station3();
    } else if (fetch("newState").equals("station4")) {
        station4();
    } else if (fetch("newState").equals("station5")) {
        station5();
    } else if (fetch("newState").equals("station6")) {
        station6();
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
            // deepCopy(vimDisplay, curVimDisplay);
            // println(vimDisplay[0]);
            // println(curVimDisplay[0]);
            store("gameScore", 0);
            for (int i=0; i<25; i++) {
                store("setupCurVimDisplayLine", loadStrings("vim_display.txt")[i]);
                for (int j=0; j<fetch("setupCurVimDisplayLine").length(); j++) {
                    curVimDisplay[i][j] = fetch("setupCurVimDisplayLine").charAt(j);
                }
            }
            for (int i=0; i<25; i++) {
                String[] words = split(new String(curVimDisplay[i]), " ");
                store("randObj", max(int(random(words.length) - 1), 0));
                gameToDelete[i][0] = join(subset(words, 0, fetchInt("randObj")), " ").length() + 1;
                gameToDelete[i][1] = gameToDelete[i][0] + words[fetchInt("randObj")].length() - 1;
            }
            store("setState", "game");
            store("gameIsThereRedSquares", "true");
        } else if (fetch("mainMenuHoveringButton").equals("exit")) {
            store("setState", "exit");
        }
    }
}

void station1() {
    store("state", "station1");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "maze");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("mazeStation1Completed", "true");
    }

    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("mazeStation1Message"), 50, 50, width-50, height-50);

}

void station2() {
    store("state", "station2");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "maze");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("mazeStation2Completed", "true");
    }
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("mazeStation2Message"), 50, 50, width-50, height-50);

}

void station3() {

    store("state", "station3");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "maze");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("mazeStation3Completed", "true");
    }
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("mazeStation3Message"), 50, 50, width-50, height-50);

}

void station4() {
    store("state", "station4");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "maze");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("mazeStation4Completed", "true");
    }
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("mazeStation4Message"), 50, 50, width-50, height-50);

}

void station5() {
    store("state", "station5");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "maze");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("mazeStation5Completed", "true");
    }
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    text(fetch("mazeStation5Message"), 50, 50, width-50, height-50);

}

void station6() {
    store("state", "station6");
    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        if (fetchBool("mazeStation6Completed")) {
            store("setState", "mainMenu");
        } else {
            store("setState", "maze");
            store("mazeY", fetchFloat("mazeY")+20);
        }
        store("keystrokes", fetch("keystrokes") + "none&");
    }
    textSize(20);
    textAlign(BASELINE, BASELINE);
    textLeading(30);
    fill(0);
    rectMode(CORNERS);
    if (fetchBool("mazeStation1Completed") && fetchBool("mazeStation2Completed") && fetchBool("mazeStation3Completed") && fetchBool("mazeStation4Completed") && fetchBool("mazeStation5Completed")) {
        store("mazeStation6Completed", "true");
    }
    if (fetchBool("mazeStation6Completed")) {
        text(fetch("mazeStation6CompleteMessage"), 50, 50, width-50, height-50);
    } else {
        text(fetch("mazeStation6IncompleteMessage"), 50, 50, width-50, height-50);
    }

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
    store("mazeMoveSpeed", 20);

    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "mainMenu");
        store("keystrokes", fetch("keystrokes") + "none");
    }

    background(200, 200, 100);

    image(mazeImg, fetchFloat("mazeX"), fetchFloat("mazeY"));

    store("mazeMaxMoveDistLeft", 20);
    store("mazeMaxMoveDistRight", 20);
    store("mazeMaxMoveDistDown", 20);
    store("mazeMaxMoveDistUp", 20);
    
    store("mazePosColor", get(width/2, height/2));
    store("mazeStation1Color", color(#FF0000));
    store("mazeStation2Color", color(#FFFF00));
    store("mazeStation3Color", color(#00FF00));
    store("mazeStation4Color", color(#00FFFF));
    store("mazeStation5Color", color(#6700FF));
    store("mazeStation6Color", color(#FF00FF));
    
    if (fetchInt("mazePosColor") == fetchInt("mazeStation1Color") && !fetchBool("mazeStation1Completed")) {
        println("station1");
        store("setState", "station1");
    } else if (fetchInt("mazePosColor") == fetchInt("mazeStation2Color") && !fetchBool("mazeStation2Completed")) {
        store("setState", "station2");
    } else if (fetchInt("mazePosColor") == fetchInt("mazeStation3Color") && !fetchBool("mazeStation3Completed")) {
        store("setState", "station3");
    } else if (fetchInt("mazePosColor") == fetchInt("mazeStation4Color") && !fetchBool("mazeStation4Completed")) {
        store("setState", "station4");
    } else if (fetchInt("mazePosColor") == fetchInt("mazeStation5Color") && !fetchBool("mazeStation5Completed")) {
        store("setState", "station5");
    } else if (fetchInt("mazePosColor") == fetchInt("mazeStation6Color") && !fetchBool("mazeStation6Completed")) {
        store("setState", "station6");
    }

    for (int i=0; i<=fetchFloat("mazeMoveSpeed"); i++) {
        if (get(width/2-i-3, height/2) == color(0, 0, 0)) {
            store("mazeMaxMoveDistLeft", i);
            break;
        }
    }

    for (int i=0; i<=fetchFloat("mazeMoveSpeed"); i++) {
        if (get(width/2, height/2-i-35) == color(0, 0, 0)) {
            store("mazeMaxMoveDistUp", i);
            break;
        }
    }

    for (int i=0; i<=fetchFloat("mazeMoveSpeed"); i++) {
        if (get(width/2+i+3, height/2) == color(0, 0, 0)) {
            store("mazeMaxMoveDistRight", i);
            break;
        }
    }

    for (int i=0; i<=fetchFloat("mazeMoveSpeed"); i++) {
        if (get(width/2, height/2+i+35) == color(0, 0, 0)) {
            store("mazeMaxMoveDistDown", i);
            break;
        }
    }


    if (fetch("keystrokes").endsWith("h")) {
        store("mazeX", fetchFloat("mazeX") + fetchFloat("mazeMaxMoveDistLeft"));
        store("mazeCharDirection", "l");
        store("keystrokes", fetch("keystrokes") + "none&");
    } else if (fetch("keystrokes").endsWith("j")) {
        store("mazeY", fetchFloat("mazeY") - fetchFloat("mazeMaxMoveDistDown"));
        store("mazeCharDirection", "d");
        store("keystrokes", fetch("keystrokes") + "none&");
    } else if (fetch("keystrokes").endsWith("k")) {
        store("mazeY", fetchFloat("mazeY") + fetchFloat("mazeMaxMoveDistUp"));
        store("mazeCharDirection", "u");
        store("keystrokes", fetch("keystrokes") + "none&");
    } else if (fetch("keystrokes").endsWith("l")) {
        store("mazeX", fetchFloat("mazeX") - fetchFloat("mazeMaxMoveDistRight"));
        store("mazeCharDirection", "r");
        store("keystrokes", fetch("keystrokes") + "none&");
    }

    fill(100, 100, 255);
    stroke(0);

    rectMode(CENTER);

    if (fetch("mazeCharDirection").equals("d")) {
        rect(width/2, height/2, 10, 30);
        
        rect(width/2-5, height/2-3, 5, 15);
        rect(width/2+5, height/2-3, 5, 15);

        rect(width/2-2.5, height/2+25, 5, 20);
        rect(width/2+2.5, height/2+25, 5, 20);
    } else if (fetch("mazeCharDirection").equals("u")) {
        rect(width/2-5, height/2-3, 5, 15);
        rect(width/2+5, height/2-3, 5, 15);

        rect(width/2-2.5, height/2+25, 5, 20);
        rect(width/2+2.5, height/2+25, 5, 20);       

        rect(width/2, height/2, 10, 30);
    } else {
        rect(width/2, height/2, 10, 30);

        rect(width/2, height/2-3, 5, 15);

        rect(width/2, height/2+25, 8, 20);
    }

    ellipseMode(RADIUS);
    circle(width/2, height/2-25, 10);

    fill(255, 255, 255);
    if (fetch("mazeCharDirection").equals("l") || fetch("mazeCharDirection").equals("d")) {
        circle(width/2-5, height/2-30, 5);
    }
    if (fetch("mazeCharDirection").equals("r") || fetch("mazeCharDirection").equals("d")) {
        circle(width/2+5, height/2-30, 5);
    }


}

void game() {
    store("state", "game");

    if (fetch("keystrokes").substring(fetchInt("keystrokesLen")-2).equals(":q")) {
        store("setState", "mainMenu");
        store("keystrokes", fetch("keystrokes") + "none&");
        store("gameScore", 0);
    }

    store("vimSelectionStartIndex", fetch("gameCursorX"));
    store("vimSelectionEndIndex", fetch("gameCursorX"));
    store("vimSelectionY", fetch("gameCursorY"));

    if (fetch("keystrokes").endsWith("e")) {
        for (int i=fetchInt("vimSelectionEndIndex"); i<24; i++) {
            if (Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i+1])) {
                store("vimSelectionEndIndex", i+1);
                break;
            }
        }
        for (int i=fetchInt("vimSelectionEndIndex"); i<24; i++) {
            if (!Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i+1])) {
                store("vimSelectionEndIndex", i);
                break;
            }
        }
    } else if (fetch("keystrokes").endsWith("w")) {
        for (int i=fetchInt("vimSelectionEndIndex"); i<24; i++) {
            if (!Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i + 1])) {
                store("vimSelectionEndIndex", i + 1);
                break;
            }
        }
        for (int i=fetchInt("vimSelectionEndIndex"); i<24; i++) {
            if (Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i + 1])) {
                store("vimSelectionEndIndex", i + 1);
                break;
            }
        }
    } else if (fetch("keystrokes").endsWith("b")) {
        for (int i=fetchInt("vimSelectionStartIndex"); i>0; i--) {
            if (Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i - 1])) {
                store("vimSelectionStartIndex", i - 1);
                break;
            }
        }
        for (int i=fetchInt("vimSelectionStartIndex"); i>=0; i--) {
            if (i == 0) {
                store("vimSelectionStartIndex", i);
                break;
            }
            if (!Character.isLetterOrDigit(curVimDisplay[fetchInt("vimSelectionY")][i - 1])) {
                store("vimSelectionStartIndex", i);
                break;
            }
        }
    } else if (fetch("keystrokes").endsWith("$")) {
        store("vimSelectionEndIndex", 24);
    } else if (fetch("keystrokes").endsWith("0")) {
        store("vimSelectionStartIndex", 0);
    } else if (fetch("keystrokes").endsWith("G")) {
        store("vimSelectionEndIndex", 0);
        store("gameCursorY", 24);
    } else if (fetch("keystrokes").endsWith("gg")) {
        store("vimSelectionStartIndex", 0);
        store("gameCursorY", 0);
    } else if (fetch("keystrokes").endsWith("h") && fetchInt("gameCursorX") != 0) {
        store("vimSelectionStartIndex", fetchInt("gameCursorX") - 1);
    } else if (fetch("keystrokes").endsWith("l") && fetchInt("gameCursorX") != 24) {
        store("vimSelectionEndIndex", fetchInt("gameCursorX") + 1);
    } else if (fetch("keystrokes").endsWith("j") && fetchInt("gameCursorY") != 24) {
        store("gameCursorY", fetchInt("gameCursorY") + 1);
    } else if (fetch("keystrokes").endsWith("k") && fetchInt("gameCursorY") != 0) {
        store("gameCursorY", fetchInt("gameCursorY") - 1);
    }

    if (fetch("keystrokes").endsWith("x")) {
        if (gameToDelete[fetchInt("gameCursorY")][0] <= fetchInt("gameCursorX") && gameToDelete[fetchInt("gameCursorY")][1] >= fetchInt("gameCursorX")) {
            gameToDelete[fetchInt("gameCursorY")][1] -= 1;
        } else if (fetchInt("gameCursorX") < gameToDelete[fetchInt("gameCursorY")][0]) {
            gameToDelete[fetchInt("gameCursorY")][0] -= 1;
            gameToDelete[fetchInt("gameCursorY")][1] -= 1;
        }
        curVimDisplay[fetchInt("gameCursorY")] = deleteSubset(curVimDisplay[fetchInt("gameCursorY")], fetchInt("gameCursorX"), fetchInt("gameCursorX"));
        store("keystrokes", "none&");
    }

    if (fetch("keystrokes").endsWith("d$")) {
        
        print("delet everything");
        curVimDisplay[fetchInt("gameCursorY")] = deleteSubset(curVimDisplay[fetchInt("gameCursorY")], fetchInt("gameCursorX"), 24);
    }
        

    if (fetch("keystrokes").charAt(fetch("keystrokes").length() - 2) == 'd' && !fetch("keystrokes").endsWith("G")) {
        if (fetch("keystrokes").endsWith("w")) {
            store("vimSelectionEndIndex", fetchInt("vimSelectionEndIndex") - 1);
        }
        store("redRegionDeleteStart", max(gameToDelete[fetchInt("gameCursorY")][0], fetchInt("vimSelectionStartIndex")));
        store("redRegionDeleteEnd", min(gameToDelete[fetchInt("gameCursorY")][1], fetchInt("vimSelectionEndIndex")));
        if (fetchInt("redRegionDeleteEnd") - fetchInt("redRegionDeleteStart") >= 0) {
            gameToDelete[fetchInt("gameCursorY")][1] -= fetchInt("redRegionDeleteEnd") - fetchInt("redRegionDeleteStart") + 1;
        } else if (fetchInt("gameCursorX") < fetchInt("redRegionDeleteStart")) {
            gameToDelete[fetchInt("gameCursorY")][0] -= fetchInt("vimSelectionEndIndex") - fetchInt("vimSelectionStartIndex") + 1;
            gameToDelete[fetchInt("gameCursorY")][1] -= fetchInt("vimSelectionEndIndex") - fetchInt("vimSelectionStartIndex") + 1;
        }
        store("mazeNumCharDelete", fetchInt("vimSelectionEndIndex") - fetchInt("vimSelectionStartIndex") + 1);
        curVimDisplay[fetchInt("gameCursorY")] = deleteSubset(curVimDisplay[fetchInt("gameCursorY")], fetchInt("vimSelectionStartIndex"), fetchInt("vimSelectionEndIndex"));
        store("vimSelectionStartIndex", fetch("gameCursorX"));
        store("vimSelectionEndIndex", fetch("gameCursorX"));
        store("keystrokes", "none&");
    }

    if (fetchInt("vimSelectionStartIndex") != fetchInt("gameCursorX")) {
        store("gameCursorX", fetchInt("vimSelectionStartIndex"));
        store("keystrokes", "none&");
    } else if (fetchInt("vimSelectionEndIndex") != fetchInt("gameCursorX")) {
        store("gameCursorX", fetchInt("vimSelectionEndIndex"));
        store("keystrokes", "none&");
    } else if (fetchInt("vimSelectionY") != fetchInt("gameCursorY")) {
        store("vimSelectionY", fetch("gameCursorY"));
        store("keystrokes", "none&");
    }

    rectMode(CENTER);
    fill(255);
    stroke(0);

    if (fetchBool("gameIsThereRedSquares")) {
        store("gameIsThereRedSquares", "false");
        for (int i=0; i<25; i++) {
            for (int j=0; j<25; j++) {
                if (fetchInt("gameCursorX") == j && fetchInt("gameCursorY") == i) {
                    fill(200, 200, 255);
                } else if (gameToDelete[i][0] <= j && gameToDelete[i][1] >= j) {
                    fill(255, 200, 200);
                    store("gameIsThereRedSquares", "true");
                } else {
                    fill(255);
                }
                rect(36*j+18, 36*i+18, 36, 36);
                fill(0);
                text(curVimDisplay[i][j], 36*j+12, 36*i+12);
            }
        }
    } else {
        fill(0);
        if (fetchInt("gameScore") == 0) {
            store("gameScore", fetch("stateCurTime"));
        }
        text("Your score is: " + fetch("gameScore") + ". The less score the better.", width/2, height/2);
        text("Type ':q' to exit.", width/2, height/2+100);
    }

    
    // println(fetch("keystrokes"));
    // if (fetch("keystrokes").endsWith("h")) {
    //     if (!(fetchInt("gameCursorX") == 0)) {
    //         store("gameCursorX", fetchInt("gameCursorX") - 1);
    //     }
    //     store("keystrokes", fetch("keystrokes") + "none&");
    // } else if (fetch("keystrokes").endsWith("j")) {
    //     if (!(fetchInt("gameCursorY") == 19)) {
    //         store("gameCursorY", fetchInt("gameCursorY") + 1);
    //     }
    //     store("keystrokes", fetch("keystrokes") + "none&");
    // } else if (fetch("keystrokes").endsWith("k")) {
    //     if (!(fetchInt("gameCursorY") == 0)) {
    //         store("gameCursorY", fetchInt("gameCursorY") - 1);
    //     }
    //     store("keystrokes", fetch("keystrokes") + "none&");
    // } else if (fetch("keystrokes").endsWith("l")) {
    //     if (!(fetchInt("gameCursorX") == 24)) {
    //         store("gameCursorX", fetchInt("gameCursorX") + 1);
    //     }
    //     store("keystrokes", fetch("keystrokes") + "none&");
    // }
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
    } else if (keyCode == SHIFT) {
        return;
    } else if (!(key == CODED)) {
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
    store("keystrokes", "none&");
    store("curVimCommand", "&");

    store("helpMessage", join(loadStrings("help.txt"), "\n"));
    store("mazeStation1Message", join(loadStrings("station1.txt"), "\n"));
    store("mazeStation2Message", join(loadStrings("station2.txt"), "\n"));
    store("mazeStation3Message", join(loadStrings("station3.txt"), "\n"));
    store("mazeStation4Message", join(loadStrings("station4.txt"), "\n"));
    store("mazeStation5Message", join(loadStrings("station5.txt"), "\n"));
    store("mazeStation6CompleteMessage", join(loadStrings("station6_complete.txt"), "\n"));
    store("mazeStation6IncompleteMessage", join(loadStrings("station6_incomplete.txt"), "\n"));

    mazeImg = loadImage("maze2.png");
    store("mazeX", 100);
    store("mazeY", 120);
    store("mazePlayerDirection", 3);
    store("mazeCharDirection", "d");

    store("mazeStation1Completed", "false");
    store("mazeStation2Completed", "false");
    store("mazeStation3Completed", "false");
    store("mazeStation4Completed", "false");
    store("mazeStation5Completed", "false");

    for (int i=0; i<25; i++) {
        store("setupCurVimDisplayLine", loadStrings("vim_display.txt")[i]);
        for (int j=0; j<fetch("setupCurVimDisplayLine").length(); j++) {
            curVimDisplay[i][j] = fetch("setupCurVimDisplayLine").charAt(j);
       }
    }

    // curVimDisplay = vimDisplay;

    store("gameCursorX", "0");
    store("gameCursorY", "0");
    store("gameVimMode", "normal");

    store("gameIsThereRedSquares", "true");
    store("gameScore", 0);
}
