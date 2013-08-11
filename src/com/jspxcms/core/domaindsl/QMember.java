package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.jspxcms.core.domain.Member;
import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;

import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QMember is a Querydsl query type for Member
 */

public class QMember extends EntityPathBase<Member> {

    private static final long serialVersionUID = 49630904;

    private static final PathInits INITS = PathInits.DIRECT;

    public static final QMember member = new QMember("member1");

    public final StringPath avatar = createString("avatar");

    public final StringPath comeFrom = createString("comeFrom");

    public final BooleanPath gender = createBoolean("gender");

    public final NumberPath<Integer> id = createNumber("id", Integer.class);

    public final QMemberGroup memberGroup;

    public final StringPath selfIntro = createString("selfIntro");

    public final NumberPath<Integer> status = createNumber("status", Integer.class);

    public final QUser user;

    public QMember(String variable) {
        this(Member.class, forVariable(variable), INITS);
    }

    @SuppressWarnings("all")
    public QMember(Path<? extends Member> path) {
        this((Class)path.getType(), path.getMetadata(), path.getMetadata().isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QMember(PathMetadata<?> metadata) {
        this(metadata, metadata.isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QMember(PathMetadata<?> metadata, PathInits inits) {
        this(Member.class, metadata, inits);
    }

    public QMember(Class<? extends Member> type, PathMetadata<?> metadata, PathInits inits) {
        super(type, metadata, inits);
        this.memberGroup = inits.isInitialized("memberGroup") ? new QMemberGroup(forProperty("memberGroup")) : null;
        this.user = inits.isInitialized("user") ? new QUser(forProperty("user"), inits.get("user")) : null;
    }

}

