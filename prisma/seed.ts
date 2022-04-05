import { Prisma, PrismaClient, Team } from '@prisma/client';
import { match } from 'assert';
import Tournament from 'round-robin-tournament';
const util = require('util');

const prisma = new PrismaClient();

const run = async () => {
  console.log('seeding...');

  const tournament: Prisma.TournamentCreateInput = {
    name: 'tour 1',
  };
  const teams = [
    {
      name: 'tour 1 team 1',
      players: { create: [{ name: 'trung dep 1' }, { name: 'trung dep 2' }] },
    },
    {
      name: 'tour 1 team 2',
      players: { create: [{ name: 'trung dep 3' }, { name: 'trung dep 4' }] },
    },
    {
      name: 'tour 1 team 3',
      players: { create: [{ name: 'trung dep 5' }, { name: 'trung dep 6' }] },
    },
    {
      name: 'tour 1 team 4',
      players: { create: [{ name: 'trung dep 7' }, { name: 'trung dep 8' }] },
    },
  ];

  try {
    // generate tournament
    const { id: tournamentId } = await prisma.tournament.create({ data: tournament });
    // generate team and player
    const teamCreatePromises = teams.map((team) => {
      const data: Prisma.TeamCreateInput = {
        ...team,
        Tournament: { connect: { id: tournamentId } },
      };
      prisma.team.create({
        data: data,
      });
    });
    const teamsResult: any = await Promise.all(teamCreatePromises);

    // // generate matches
    const tourObj = new Tournament(teamsResult);
    const matches = tourObj.matches.flat();
    const matchCreatePromises = matches.map((match, index) =>
      prisma.match.create({
        data: {
          order: index,
          // @ts-ignore: Unreachable code error
          home: { connect: { id: match[0].id } },
          // @ts-ignore: Unreachable code error
          away: { connect: { id: match[1].id } },
          Tournament: { connect: { id: tournamentId } },
        },
      })
    );
    const matchesCreateResult = await Promise.all(matchCreatePromises);
    const matchScoreCreatePromises = [];
    // for each match, home player 1 score once
    for (const match of matchesCreateResult) {
      if (!match.homeId) return;
      const players = await prisma.player.findMany({
        where: {
          Team: {
            some: {
              id: match?.homeId,
            },
          },
        },
      });

      const payload = prisma.matchScore.create({
        data: {
          scorer: { connect: { id: players[0]?.id } },
          assistor: { connect: { id: players[1]?.id } },
          Match: { connect: { id: match.id } },
        },
      });
      matchScoreCreatePromises.push(payload);
    }
    await Promise.all(matchScoreCreatePromises);
  } catch (e) {
    console.log(e);
  } finally {
    await prisma.$disconnect();
  }
};

run()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
