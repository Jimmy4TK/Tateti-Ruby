# API Tateti

# Clone Repository
```bash
cd /path
git clone https://github.com/Jimmy4TK/Tateti-Ruby.git
cd Tateti-Ruby
```

# Set Up

## Install bundle

```bash
cd ~Tateti-Ruby
gem install bundle
bundle install
```

## Set Up Database

```bash
Rails db:create
Rails db:migrate
Rails db:seed
```

# Use Api

# User Controller

## Create User (Register)

### The method needs params: password, password2 and user with name, email and password. Method returns user token

## Login

### The method needs params: email and password. Method returns user token

## Current

### The method needs params: user token. Method returns user that corresponds to the token

## Password

### The method needs params: user token, currentPassword, newPassword and newPassword2. Method returns password changed


# Game Controller

## Create

### The method needs params: user token. Method returns game created with its creator

## Game

### The method needs params: position(modified position number) and game id. Method verify if game is finish (win team red, green or draw) and return occupied positions and the team whose turn it is 

## Check player

### The method needs params game id. Method returns game with players

## Assign player

### The method needs params game id and user token. Method return game with 2 players

## Incomplete

### The method return games with only 1 player






