/*
  Warnings:

  - You are about to drop the column `teamAId` on the `Match` table. All the data in the column will be lost.
  - You are about to drop the column `teamBId` on the `Match` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Match" DROP CONSTRAINT "Match_teamAId_fkey";

-- DropForeignKey
ALTER TABLE "Match" DROP CONSTRAINT "Match_teamBId_fkey";

-- AlterTable
ALTER TABLE "Match" DROP COLUMN "teamAId",
DROP COLUMN "teamBId",
ADD COLUMN     "awayId" INTEGER,
ADD COLUMN     "created" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "homeId" INTEGER,
ADD COLUMN     "updated" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "MatchEvent" ADD COLUMN     "created" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Player" ADD COLUMN     "created" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "name" TEXT,
ADD COLUMN     "updated" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Team" ADD COLUMN     "created" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "name" TEXT,
ADD COLUMN     "updated" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Tournament" ADD COLUMN     "name" TEXT,
ADD COLUMN     "updated" TIMESTAMP(3);

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_awayId_fkey" FOREIGN KEY ("awayId") REFERENCES "Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;
