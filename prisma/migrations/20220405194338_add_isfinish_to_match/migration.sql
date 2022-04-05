/*
  Warnings:

  - Made the column `tournamentId` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `awayId` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `homeId` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `order` on table `Match` required. This step will fail if there are existing NULL values in that column.
  - Made the column `matchId` on table `MatchScore` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created` on table `MatchScore` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated` on table `MatchScore` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created` on table `Player` required. This step will fail if there are existing NULL values in that column.
  - Made the column `name` on table `Player` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated` on table `Player` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created` on table `Team` required. This step will fail if there are existing NULL values in that column.
  - Made the column `name` on table `Team` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated` on table `Team` required. This step will fail if there are existing NULL values in that column.
  - Made the column `tournamentId` on table `Team` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created` on table `Tournament` required. This step will fail if there are existing NULL values in that column.
  - Made the column `name` on table `Tournament` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated` on table `Tournament` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Match" DROP CONSTRAINT "Match_awayId_fkey";

-- DropForeignKey
ALTER TABLE "Match" DROP CONSTRAINT "Match_homeId_fkey";

-- DropForeignKey
ALTER TABLE "Match" DROP CONSTRAINT "Match_tournamentId_fkey";

-- DropForeignKey
ALTER TABLE "MatchScore" DROP CONSTRAINT "MatchScore_matchId_fkey";

-- DropForeignKey
ALTER TABLE "Team" DROP CONSTRAINT "Team_tournamentId_fkey";

-- AlterTable
ALTER TABLE "Match" ADD COLUMN     "isFinish" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "tournamentId" SET NOT NULL,
ALTER COLUMN "awayId" SET NOT NULL,
ALTER COLUMN "created" SET NOT NULL,
ALTER COLUMN "homeId" SET NOT NULL,
ALTER COLUMN "updated" SET NOT NULL,
ALTER COLUMN "order" SET NOT NULL;

-- AlterTable
ALTER TABLE "MatchScore" ALTER COLUMN "matchId" SET NOT NULL,
ALTER COLUMN "created" SET NOT NULL,
ALTER COLUMN "updated" SET NOT NULL;

-- AlterTable
ALTER TABLE "Player" ALTER COLUMN "created" SET NOT NULL,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "updated" SET NOT NULL;

-- AlterTable
ALTER TABLE "Team" ALTER COLUMN "created" SET NOT NULL,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "updated" SET NOT NULL,
ALTER COLUMN "tournamentId" SET NOT NULL;

-- AlterTable
ALTER TABLE "Tournament" ALTER COLUMN "created" SET NOT NULL,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "updated" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_awayId_fkey" FOREIGN KEY ("awayId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MatchScore" ADD CONSTRAINT "MatchScore_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "Match"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
