/*
  Warnings:

  - You are about to drop the column `hasAssist` on the `MatchScore` table. All the data in the column will be lost.
  - You are about to drop the column `playerId` on the `MatchScore` table. All the data in the column will be lost.
  - Added the required column `assistorId` to the `MatchScore` table without a default value. This is not possible if the table is not empty.
  - Added the required column `scorerId` to the `MatchScore` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "MatchScore" DROP CONSTRAINT "MatchScore_playerId_fkey";

-- AlterTable
ALTER TABLE "MatchScore" DROP COLUMN "hasAssist",
DROP COLUMN "playerId",
ADD COLUMN     "assistorId" INTEGER NOT NULL,
ADD COLUMN     "scorerId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "MatchScore" ADD CONSTRAINT "MatchScore_scorerId_fkey" FOREIGN KEY ("scorerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MatchScore" ADD CONSTRAINT "MatchScore_assistorId_fkey" FOREIGN KEY ("assistorId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
