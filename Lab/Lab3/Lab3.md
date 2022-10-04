# Lab3: Flexible
After learning queue and stack in class, you are wondering if there is something more flexible. Maybe a list supporting pop and push on both sides sounds great.
You should maintain such a list, and support 4 operations:

- `+s` : push `s` to the left side
- `- `: pop a char from the left side and print it
- `[s` : push s to the right side
- `]` : pop a char from the right side and print it

Here, the list is empty at first, and `s` can be letters either lowercase or uppercase. If the list pops when empty, just print a `_` as the result.
## Sample Input
`-+a+D+d+o+A][b-]`
## Sample Output
`-+a+D+d+o+A][b-]`
`_aAb`
Notice: echo included
## Limitation
There are at most x100 operations and the list will contain at most x80 elements at any time.
## Explanation:
| Operation | List | Output |
| --- | --- | --- |
| - |  | _ |
| +a | a |  |
| +D | Da |  |
| +d | dDa |  |
| +o | odDa |  |
| +A | AodDa |  |
| ] | AodD | a |
| [b | AodDb |  |
| - | odDb | A |
| ] | odD | b |

## Requirements

- Write program with **LC-3 assembly language**
- Start your program at `x3000`
- You can refer to APPENDIX A.1 for the address space you are allowed (Unprivileged Memory) to use.
- Use trap x20 to input (prompt of trap x23 is not allowed), and echo the input. Your output should be in the second line.
- The input will only contain the operations mentioned above and end with newline ( `10 `in ASCII)
- Remember to halt your program in the end
- **NO CHEATING**

## Check (50%)

- Contact to your lab TA to check your code. In most cases, it is required to be **OFFLINE**.
- TA will test your code in different cases. Correctness is the primary factor in grading.
- TA will ask you questions to make sure you finish it on your own. It is very important to be familiar with the lab and your code. Suggestion: write some comments in case you forget what your code means.
- You can retry if you fails a check, but there will be a penalty of 10% points in Check part each time.
## Report (50%)

- Written in **English**, concise and complete
- Convince TA that you finish the lab on your own
- **No more than** 3 A4 pages
- Consisting of:
   - Algorithm explanation
   - Essential parts of your code with sufficient comments
   - Questions TA asked you and your answer in Check
## Other Penalty

- Delay: -10% each day after ddl
- Cheating: -100%, and -10% in final score of the course
