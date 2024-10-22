/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jdorazio <jdorazio@student.42madrid.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/22 12:10:47 by jdorazio          #+#    #+#             */
/*   Updated: 2024/10/22 12:13:00 by jdorazio         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	main(void)
{
	int		fd;
	char	*line;

	fd = open("file1.txt", O_RDONLY);
	if (fd < 0)
		return (perror ("Error opening file"), 1);
	line = get_next_line(fd);
	while (line != NULL)
	{
		if (line == NULL)
			printf("NULL CHECK: get next line return NULL unexpectedly.\n");
		else
		{
			printf("Line: %s \n", line);
			free(line);
		}
	}
	if (close(fd) < 0)
	{
		perror("Error closing file");
		return (1);
	}
	return (0);
}
