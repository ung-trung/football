import { PrismaClient } from '@prisma/client';
import { InferGetStaticPropsType, GetStaticPropsContext } from 'next';

export const getStaticProps = async () => {
  const prisma = new PrismaClient();
  const tournaments = await prisma.tournament.findMany({
    select: {
      name: true,
    },
  });
  return {
    props: { tournaments },
    revalidate: 10,
  };
};
function Tournaments(props: InferGetStaticPropsType<typeof getStaticProps>) {
  return (
    <div>
      <ul>
        {props.tournaments.map((t) => (
          <li>{t.name}</li>
        ))}
      </ul>
    </div>
  );
}
export default Tournaments;
