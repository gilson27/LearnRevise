'''
    Find highest Unique Element in array
'''

def find_unique_elt_in_arr():
    n = int(input())
    l_elt = -1
    t_buff = -1
    n_o = 0
    list_n = list(map(int, input().split()))
    list_n.sort(reverse = True)
    for k, v in enumerate(list_n):
        if v != tbuff:
            n_o = 1
            t_buff = v
            if k != 0 && :
                break
        else:
            n_o+=1
            
    print(t_buff)

'''
    Call the function
'''
find_unique_elt_in_arr()  
    
