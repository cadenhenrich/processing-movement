enum Direction {
    none, left, right
}

class Player {
    PVector position;
    PVector velocity;
    Direction direction;
    float maxVelocity;
    float acceleration;
    float jumpSpeed;
    int w, h;
    boolean onGround;
    boolean onWall;
    int numJumps;

    Player(PVector position, float acceleration, float maxVelocity, float jumpSpeed) {
        this.position = position;
        this.acceleration = acceleration;
        this.maxVelocity = maxVelocity;
        this.jumpSpeed = jumpSpeed;
        this.velocity = new PVector(0,0);
        this.direction = Direction.none;
        this.w = 50;
        this.h = 50;
    }

    void show() {
        fill(0);
        rect(position.x, position.y, w, h);
    }

    void move(float gravity) {
        switch (this.direction) {
            case none:
                if (this.velocity.x < 0) this.velocity.x += acceleration;
                if (this.velocity.x > 0) this.velocity.x -= acceleration;
                if (this.velocity.x > -1 && this.velocity.x < 1)
                    this.velocity.x = 0;
                break;
            case left:
                this.velocity.x -= acceleration;
                if (this.velocity.x <= -maxVelocity) {
                    this.velocity.x = -maxVelocity - 0.1;
                }
                break;
            case right:
                this.velocity.x += acceleration;
                if (this.velocity.x >= maxVelocity) {
                    this.velocity.x = maxVelocity - 0.1;
                }
                break;
        }

        this.velocity.y += gravity;
        this.position.add(this.velocity);

        if (this.position.x < 0) {
            this.position.x = 0.1f;
            this.velocity.x = 0;
            onWall = true;
        } else if (this.position.x + w > width) {
            this.position.x = width - w - 0.1f;
            this.velocity.x = 0;
            onWall = true;
        } else {
            onWall = false;
        }

        if (onWall) {
            numJumps = 1;
        }

        if (this.position.y + w > height) {
            this.position.y = height - h - 0.1f;
            this.velocity.y = 0;
            onGround = true;
            numJumps = 0;
        } else if (this.position.y < 0) {
            this.position.y = 0.1f;
            this.velocity.y = 0;
            onGround = false;
        } else {
            onGround = false;
        }
    }

    void setDirection(Direction newDirection) {
        this.direction = newDirection;
    }

    void jump() {
        if (onGround || onWall || numJumps < 2) {
            this.velocity.y = -jumpSpeed;
            numJumps++;
        }
    }
}
