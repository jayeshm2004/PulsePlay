import uuid
import bcrypt
from fastapi import Depends, HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import Session

from pydantic_schemas.user_login import UserLogin

router=APIRouter()

@router.post('/signup',status_code=201)
def signup_user(user: UserCreate,db:Session=Depends(get_db)):
    #extract the data coming from the request
    #check if user already exists
    #if not then add the user to db
    user_db=db.query(User).filter(User.email==user.email).first()
    
    if user_db:
        raise HTTPException(400,'User already exists')
    
    hashed_pw=bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
    user_db=User(id=str(uuid.uuid4()),name=user.name,email=user.email,password=hashed_pw)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    
    
    return user_db


@router.post('/login')
def login_user(user:UserLogin,db:Session=Depends(get_db)):
    #check if the user already exists
    #if yes allow login 
    #if not ask to signup first
    user_db=db.query(User).filter(User.email==user.email).first()
    
    if not user_db:
        raise HTTPException(400,'User with this email does not exist')
    
    #check if password matches
    hashed_pw=bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
    
    
    is_match=bcrypt.checkpw(user.password.encode(),user_db.password)
    
    if not is_match:
        raise HTTPException(400,'password doesn\'t match')
    
    
    return user_db
    