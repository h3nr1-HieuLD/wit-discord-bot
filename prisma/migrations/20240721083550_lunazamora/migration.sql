-- CreateEnum
CREATE TYPE "REQUEST_TYPE" AS ENUM ('OFF', 'LATE');

-- CreateEnum
CREATE TYPE "REQUEST_STATUS_TYPE" AS ENUM ('APPROVED', 'WAITING', 'REJECTED');

-- CreateTable
CREATE TABLE "RequestOffOrLate" (
    "requestId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "type" "REQUEST_TYPE" NOT NULL DEFAULT 'LATE',
    "note" TEXT NOT NULL,
    "status" "REQUEST_STATUS_TYPE" NOT NULL DEFAULT 'WAITING',
    "admin_note" TEXT NOT NULL,

    CONSTRAINT "RequestOffOrLate_pkey" PRIMARY KEY ("requestId")
);

-- AddForeignKey
ALTER TABLE "RequestOffOrLate" ADD CONSTRAINT "RequestOffOrLate_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE RESTRICT ON UPDATE CASCADE;
