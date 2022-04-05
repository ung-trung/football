import { PrismaClient } from '@prisma/client';
import type { NextApiRequest, NextApiResponse } from 'next';

export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { method } = req;
  if (method === 'POST') {
    const prisma = new PrismaClient();
    const result = await prisma.tournament.create({ data: JSON.parse(req.body) });
    res.status(200).json(result);
  }
};
