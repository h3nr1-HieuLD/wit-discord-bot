-- CreateEnum
CREATE TYPE "AttachmentType" AS ENUM ('FILE', 'ASSIGNMENT', 'DOC', 'VIDEO');

-- CreateEnum
CREATE TYPE "SUBMISSION_STATUS" AS ENUM ('PENDING', 'ACCEPTED', 'REJECTED');

-- CreateTable
CREATE TABLE "Member" (
    "memberId" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Member_pkey" PRIMARY KEY ("memberId")
);

-- CreateTable
CREATE TABLE "DiscordMember" (
    "id" SERIAL NOT NULL,
    "discordId" TEXT NOT NULL,
    "missTime" INTEGER NOT NULL DEFAULT 0,
    "username" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DiscordMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordMeet" (
    "id" SERIAL NOT NULL,
    "joined" TEXT NOT NULL,
    "channel" TEXT NOT NULL DEFAULT 'none',
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DiscordMeet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Administrator" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL DEFAULT 'noemail',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Administrator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordAdminId" (
    "id" SERIAL NOT NULL,
    "discordId" TEXT NOT NULL,

    CONSTRAINT "DiscordAdminId_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Courses" (
    "courseId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT 'Không có thông tin',
    "thumbnail" TEXT NOT NULL DEFAULT 'https://via.placeholder.com/150',

    CONSTRAINT "Courses_pkey" PRIMARY KEY ("courseId")
);

-- CreateTable
CREATE TABLE "Lessons" (
    "LessonId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" VARCHAR(1000) NOT NULL DEFAULT 'Không có thông tin',
    "courseId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Lessons_pkey" PRIMARY KEY ("LessonId")
);

-- CreateTable
CREATE TABLE "LessonChapters" (
    "chapterId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" VARCHAR(500) NOT NULL DEFAULT 'Không có thông tin',
    "LessonId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LessonChapters_pkey" PRIMARY KEY ("chapterId")
);

-- CreateTable
CREATE TABLE "Attachments" (
    "attachmentId" TEXT NOT NULL,
    "type" "AttachmentType" NOT NULL DEFAULT 'DOC',
    "chapterId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "fileId" TEXT,
    "videoUrl" TEXT,
    "markdown" TEXT,

    CONSTRAINT "Attachments_pkey" PRIMARY KEY ("attachmentId")
);

-- CreateTable
CREATE TABLE "Contests" (
    "contestId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "thumbnail" TEXT NOT NULL DEFAULT 'https://via.placeholder.com/150',
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Contests_pkey" PRIMARY KEY ("contestId")
);

-- CreateTable
CREATE TABLE "UserJoinContests" (
    "memberId" TEXT NOT NULL,
    "contestId" TEXT NOT NULL,
    "totalScore" INTEGER NOT NULL DEFAULT 0,
    "problemIndex" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserJoinContests_pkey" PRIMARY KEY ("memberId","contestId")
);

-- CreateTable
CREATE TABLE "Problems" (
    "problemId" TEXT NOT NULL,
    "point" INTEGER NOT NULL DEFAULT 5,
    "contestId" TEXT NOT NULL,
    "problemMarkdown" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Problems_pkey" PRIMARY KEY ("problemId")
);

-- CreateTable
CREATE TABLE "Submissions" (
    "submissionId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "scores" INTEGER NOT NULL DEFAULT 0,
    "status" "SUBMISSION_STATUS" NOT NULL DEFAULT 'PENDING',
    "problemId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Submissions_pkey" PRIMARY KEY ("submissionId")
);

-- CreateTable
CREATE TABLE "UserUnlockedChapter" (
    "memberId" TEXT NOT NULL,
    "chapterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserUnlockedChapter_pkey" PRIMARY KEY ("memberId","chapterId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Member_username_key" ON "Member"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Member_email_key" ON "Member"("email");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordMember_discordId_key" ON "DiscordMember"("discordId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordMeet_channel_key" ON "DiscordMeet"("channel");

-- CreateIndex
CREATE UNIQUE INDEX "Administrator_username_key" ON "Administrator"("username");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordAdminId_discordId_key" ON "DiscordAdminId"("discordId");

-- AddForeignKey
ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Courses"("courseId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LessonChapters" ADD CONSTRAINT "LessonChapters_LessonId_fkey" FOREIGN KEY ("LessonId") REFERENCES "Lessons"("LessonId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attachments" ADD CONSTRAINT "Attachments_chapterId_fkey" FOREIGN KEY ("chapterId") REFERENCES "LessonChapters"("chapterId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserJoinContests" ADD CONSTRAINT "UserJoinContests_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserJoinContests" ADD CONSTRAINT "UserJoinContests_contestId_fkey" FOREIGN KEY ("contestId") REFERENCES "Contests"("contestId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Problems" ADD CONSTRAINT "Problems_contestId_fkey" FOREIGN KEY ("contestId") REFERENCES "Contests"("contestId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Submissions" ADD CONSTRAINT "Submissions_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Submissions" ADD CONSTRAINT "Submissions_problemId_fkey" FOREIGN KEY ("problemId") REFERENCES "Problems"("problemId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserUnlockedChapter" ADD CONSTRAINT "UserUnlockedChapter_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserUnlockedChapter" ADD CONSTRAINT "UserUnlockedChapter_chapterId_fkey" FOREIGN KEY ("chapterId") REFERENCES "LessonChapters"("chapterId") ON DELETE RESTRICT ON UPDATE CASCADE;
