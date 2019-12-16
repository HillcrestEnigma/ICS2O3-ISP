StringDict state = new StringDict();
PImage mazeImg;
PFont font;
StringList curVimDisplay;

void store(String dict_key, int value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, float value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, String value) {
    state.set(dict_key, value);
}

String fetch(String key) {
   return state.get(key);
}

int fetchInt(String key) {
    return Integer.parseInt(fetch(key));
}

float fetchFloat(String key) {
    return Float.parseFloat(fetch(key));
}

void animation() {

    store("curTime", millis());
    if (fetchInt("curTime") - fetchInt("initTime") < 30000) {
        store("state", "animation");
        store("aniTime", fetchInt("curTime") - fetchInt("initTime"));
        if (fetchInt("aniTime") < 10000) {
            store("aniScene", "typing");
        } else if (fetchInt("aniTime") < 15000) {
            store("aniScene", "submitting");
        } else if (fetchInt("aniTime") < 20000) {
            store("aniScene", "frown");
        } else if (fetchInt("aniTime") < 25000) {
            store("aniScene", "learning");
        } else {
            store("aniScene", "fadeout");
        }
    }
}

void mainMenu() {
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

}

void goodbye() {

}

void game() {
    
}

void draw() {
    animation();
    background(255);
    if (fetch("aniScene").equals("typing") || fetch("aniScene").equals("submitting") || fetch("aniScene").equals("learning") } || fetch("aniScene").equals("fadeout")) {
        rectMode(CORNERS); 
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
        }
    } else if (fetch("aniScene").equals("frowning")) {
        :
    }

    fill(0);
    textSize(15);
    text("("+mouseX+", "+mouseY+")", mouseX, mouseY);
}

void setup() {
    size(900, 900);
    frameRate(30);
    font = createFont("font.ttf", 20);
    textFont(font);
    store("initTime", millis());   
    store("aniScene", "none");
}
