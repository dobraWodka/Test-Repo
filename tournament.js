//
// This is only a SKELETON file for the 'Tournament' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
class Team {
  constructor(name) {
    this.name = name;
    this.played = 0;
    this.won = 0;
    this.drawn = 0;
    this.lost = 0;
    this.points = 0;
  }
  win() {
    this.played++;
    this.won++;
    this.points += 3;
  }
  draw() {
    this.played++;
    this.drawn++;
    this.points++;
  }
  loose() {
    this.played++;
    this.lost++;
  }
}
let emptyScoreboard = `Team                           | MP |  W |  D |  L |  P`;
export const tournamentTally = (str) => {
  if (str === "") return emptyScoreboard;
  let teams1 = [];
  let stringToTeam = new Map();
  let matches = str.split("\n").map((match) => match.split(";"));
  let teamNames = new Set();
  let result = emptyScoreboard + "\n";

  matches.forEach((item) => {
    item.forEach((x) => {
      if (x !== "win" && x !== "loss" && x !== "draw") teamNames.add(x);
    });
  });

  teamNames.forEach((teamName) => {
    teams1.push(new Team(teamName));
  });
  teams1.forEach((team) => {
    stringToTeam.set(team.name, team);
  });

  matches.forEach((item) => {
    let matchResult = item[2];
    if (matchResult === "win") {
      stringToTeam.get(item[0]).win();
      stringToTeam.get(item[1]).loose();
    } else if (matchResult === "loss") {
      stringToTeam.get(item[0]).loose();
      stringToTeam.get(item[1]).win();
    } else {
      stringToTeam.get(item[0]).draw();
      stringToTeam.get(item[1]).draw();
    }
  });

  teams1.sort((a, b) =>
    a.points !== b.points
      ? b.points - a.points
      : a.name > b.name
      ? 1
      : b.name > a.name
      ? -1
      : 0
  );
  teams1.forEach((team, index) => {
    if (team.played > 0 && index === teams1.lenght - 1) {
      result += createResultString(team);
    } else if (team.played > 0) result += createResultString(team) + "\n";
  });
  return result.substring(0, result.length - 1);
};
function createResultString(team) {
  return `${team.name.padEnd(31)}|${String(team.played).padStart(3)} |${String(
    team.won
  ).padStart(3)} |${String(team.drawn).padStart(3)} |${String(
    team.lost
  ).padStart(3)} |${String(team.points).padStart(3)}`;
}
