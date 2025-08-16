#include <stdio.h>
#include <stdlib.h>
#include <stdint.h> 

extern uint8_t ImageFlipHorizontal(uint8_t* input3DArray, uint8_t* output3DArray, uint8_t m, uint8_t n); 

int main()
{
	uint8_t width = 3, height = 3;
 	uint8_t input[3][3][3] = {
        {
           
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9},
        },
          {
            {1, 2, 6},
            {2, 6, 7},
            {9, 4, 8}, 
        },
        {
            {1, 5, 7},
            {1, 3, 3},
            {3, 4, 6},
        }
    };

	uint8_t i, j, k;
	
	uint8_t (*output)[3][3] = calloc(3, sizeof *output);
	
    printf("Original Image: \n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printf("[");
            for (k = 0; k < 3; k++) {
                printf("%d", input[i][j][k]);
                if (k < 2) {
                    printf(" ");
                }
            }
            printf("] ");
        }
        printf("\n");
    }
	
    ImageFlipHorizontal((uint8_t*)input, (uint8_t*)output, height, width);

    printf("\nManipulated Image (Image Flip Horizontal): \n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printf("[");
            for (k = 0; k < 3; k++) {
                printf("%d", output[i][j][k]);
                if (k < 2) {
                    printf(" ");
                }
            }
            printf("] ");
        }
        printf("\n");
    }

	return 0;
}
