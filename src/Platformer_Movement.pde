Player p;
float gravity;

enum State {
    title, paused, active
}

State gameState;

void setup() {
    size(1600, 900);
    p = new Player(new PVector(width / 2, height / 2), 2, 20, 20);
    gravity = 1;
    gameState = State.title;
}

void draw() {
    background(255);
    p.show();
    if (gameState != State.paused) {
        p.move(gravity);

        if (gameState == State.title) {
            textSize(32);
            textAlign(CENTER, CENTER);
            text("Press SPACE to start the game.", width / 2, 100);
        }
    } else {
        textSize(32);
        textAlign(CENTER, CENTER);
        text("PAUSED", width / 2, 100);
    }
}

void keyPressed() {
    if (gameState == State.active) {
        switch (key) {
            case 'w':
                p.jump();
                break;
            case 'a':
                p.setDirection(Direction.left);
                break;
            case 'd':
                p.setDirection(Direction.right);
                break;
        }
    }

    if (key == ' ') {
        gameState = gameState == State.active ? State.paused : State.active;
    }

    if (keyCode == ESC) {
        exit();
    }
}

void keyReleased() {
    if (key == 'a' || key == 'd') {
        p.setDirection(Direction.none);
    }
}
