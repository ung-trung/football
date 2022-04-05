import { TextInput, Checkbox, Button, Group, Box } from '@mantine/core';
import { useForm } from '@mantine/form';
function TournamentCreate() {
  const form = useForm({
    initialValues: {
      name: '',
    },
  });
  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <form
        onSubmit={form.onSubmit(async (values) => {
          const response = await fetch('/api/tournaments', {
            method: 'POST',
            body: JSON.stringify(values),
          });
          const data = await response.json();
          console.log('data');
        })}
      >
        <TextInput required label="Name" placeholder="Name" {...form.getInputProps('name')} />
        <Group position="right" mt="md">
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
}

export default TournamentCreate;
